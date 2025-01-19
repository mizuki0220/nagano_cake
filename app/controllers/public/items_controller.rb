class Public::ItemsController < ApplicationController

  def index
    if params[:genre]
      @genre = params[:genre]
      @items = Item.joins(:genre).where(genres: { name: @genre })
    else
      @items = Item.all
    end
    @items_page = Item.page(params[:page])
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :is_active)
  end


end
