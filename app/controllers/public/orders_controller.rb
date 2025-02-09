class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def index
  end

  def show
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_fee = 800 # 固定送料
    @order.total_price = CartItem.total_price(current_customer.cart_items) + @order.shipping_fee # 合計金額を計算
    @order.pay_method = params[:order][:payment_method]

    # 住所選択の処理
    case params[:order][:address_option].to_i
    when 0  # 自分の住所
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    when 1  # 登録済み住所
      address = Address.find(params[:order][:address_id])
      @order.postal_code = address.postal_code
      @order.address = address.address
      @order.name = address.name
    when 2  # 新しいお届け先（フォーム入力）
      # すでに `order_params` で取得されているため特に処理不要
    end

    # 確認画面へ情報を渡すために `session` を使う
    session[:order] = @order.attributes

    redirect_to completion_orders_path
  end

  def confirm
    @order = Order.new(session[:order]) # セッションからデータを取得
    @cart_items = current_customer.cart_items.includes(:item) # カート内の商品を取得
  end

  private

  def order_params
    params.require(:order).permit(:name, :postal_code, :address, :pay_method)
  end

end
