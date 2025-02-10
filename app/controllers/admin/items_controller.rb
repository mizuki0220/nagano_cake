class Admin::ItemsController < ApplicationController
  layout 'admin'

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "正常に登録しました"
      redirect_to admin_item_path(@item.id)
    else
      @items = Item.all
      flash[:alert] = "登録に失敗しました"
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "編集が完了しました。"
      redirect_to admin_item_path
    else
      flash[:alert] = "登録に失敗しました。"
      render :edit
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :genre_id, :is_active, :image)
  end
end
