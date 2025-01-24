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
      flash[:notice] = "新しい配送先の登録が完了しました。"
      redirect_to addresses_path
    else
      @addresses = Address.all
      flash[:alert] = "新しい配送先内容に不備があります。"
      render :index
    end
  end

  def update
  end

  def destroy
  end

  private
  def address_params
    params.require(:address).permit(:name, :postal_code, :address, :customer_id)
  end

end
