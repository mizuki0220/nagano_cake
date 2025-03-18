class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def show
    @order = Order.find_by(id: params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if params[:order][:is_active] == "発送済" && @order.order_details.where.not(is_active: "製作完了").exists?
      flash[:alert] = "すべての製作ステータスが『製作完了』でないと『発送済』に変更できません。"
      redirect_to admin_order_path(@order) and return
    end

    if @order.update(order_params)
      flash[:notice] = "注文ステータスを変更しました"
      redirect_to admin_order_path(@order)
    else
      flash[:alert] = "注文ステータスを更新できませんでした"
      render :show
    end
  end

  private

    def order_params
      params.require(:order).permit(:customer_id, :name, :postal_code, :address, :shipping_fee, :total_price, :payment_method, :is_active)
    end
end
