class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
  end

  def update
  end

  def create
  end

  def destroy
  end
end
