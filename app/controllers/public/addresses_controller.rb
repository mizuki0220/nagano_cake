class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
  end

  def edit
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      flash[:notice] = "正常に登録しました"
      redirect_to addresses_path
    else
      @addresses = Genre.all
      flash[:alert] = "登録に失敗しました"
      render :index
    end
  end

  def update
  end

  def destroy
  end
end
