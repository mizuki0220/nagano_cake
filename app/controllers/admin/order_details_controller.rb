class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      flash[:notice] = "製作ステータスを変更しました"
      redirect_to admin_order_path(@order_detail.order)
    else
      flash[:alert] = "製作ステータスを更新できませんでした"
      render :show
    end
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :quantity, :price, :is_active)
  end
end
