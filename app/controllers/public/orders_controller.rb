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
    if @order.save
      flash[:notice] = "正常に登録しました"
      redirect_to confirm_orders_path
    else
      @orders = Order.all
      flash[:alert] = "登録に失敗しました"
      render :new
    end
  end

  def confirm
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :name, :post_code, :address, :shipping_fee, :total_price, :pay_method, :is_active)
  end
end
