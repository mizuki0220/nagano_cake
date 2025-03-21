class Public::ItemsController < ApplicationController

  def index
    if params[:genre]
      @genre = params[:genre]
      @items = Item.joins(:genre).where(genres: { name: @genre })
    else
      @items = Item.all
    end
    @items_page = Item.page(params[:page])
    if params[:query].present?
      @items = Item.where("name LIKE ? OR introduction LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").page(params[:page]).per(10)
    else
      @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end


  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :is_active)
  end


end
