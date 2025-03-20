class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:notice] = "個数を変更しました"
      redirect_to cart_items_path
    else
      flash[:alert] = "正しい個数を入力してください"
      render :index
    end
  end

  def create
    cart_item = current_customer.cart_items.find_by(item_id: cart_item_params[:item_id]) # customer_id も考慮

    if cart_item.present?
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.update(amount: cart_item.amount)
    else
      cart_item = current_customer.cart_items.new(cart_item_params) # ここで customer_id を自動設定
      cart_item.save
    end

    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path

  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

  def authenticate_customer!
    unless current_customer
      redirect_to new_customer_session_path, alert: "ログインしてください"
    end
  end
end
