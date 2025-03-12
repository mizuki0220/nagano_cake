class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find_by(id: params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "個数を変更しました"
      redirect_to admin_order_path
    else
      flash[:alert] = "正しい個数を入力してください"
      render :show
    end
  end
end
