class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order = Order.find_by(id: params[:id])

    if @order.nil?
      Rails.logger.error "Order not found with id: #{params[:id]}"
      return render plain: "注文が見つかりません", status: :not_found
    else
      Rails.logger.debug "Order found: #{@order.inspect}"
      Rails.logger.debug "Order.customer: #{@order.customer.inspect}" if @order.respond_to?(:customer)
    end

    @order_details = OrderDetail.where(order_id: @order.id)
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        OrderDetail.create!(
          item_id: cart_item.item_id,
          order_id: @order.id,
          quantity: cart_item.amount,
          price: cart_item.item.price,
          is_active: 0
        )
      end
      @cart_items.destroy_all
      redirect_to completion_orders_path
    else
      flash[:danger] = "注文の処理中にエラーが発生しました"
      redirect_back(fallback_location: confirm_orders_path)
    end
  end

  def confirm
    @order = Order.new(order_params) # address_option はここで渡さない
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order.customer_id = current_customer.id
    @order.shipping_fee = 800 # 固定送料
    @order.total_price = CartItem.total_price(current_customer.cart_items) + @order.shipping_fee
    @order.payment_method = params[:order][:payment_method].to_i

    address_option = params[:order][:address_option].to_i

    case address_option
    when 0
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = "#{current_customer.first_name} #{current_customer.last_name}"
    when 1
      address = Address.find_by(id: params[:order][:address_id])
      if address
        @order.postal_code = address.postal_code
        @order.address = address.address
        @order.name = address.name
      else
        flash[:danger] = "選択された住所が存在しません。"
        return redirect_to new_order_path
      end
    when 2
      # すでに `order_params` で取得済み
      unless @order.valid?
        flash[:danger] = "お届け先の内容に不備があります<br>・#{@order.errors.full_messages.join('<br>・')}"
        return render :new
      end
    else
      flash[:danger] = "お届け先を選択してください。"
      return redirect_to new_order_path
    end

    render :confirm
  end


  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :shipping_fee, :total_price, :payment_method, :other_attributes, :address_id...).tap do |p|
    p[:payment_method] = p[:payment_method].to_i if p[:payment_method].present?
  end
  end

  def authenticate_customer!
    unless current_customer
      redirect_to new_customer_session_path, alert: "ログインしてください"
    end
  end

end
