class Admin::ItemsController < ApplicationController
  layout 'admin'


  def index
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
  end

  def update
  end

  def edit
  end
end
