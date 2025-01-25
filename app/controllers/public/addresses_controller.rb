class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
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
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "編集が完了しました。"
      redirect_to addresses_path
    else
      flash[:alert] = "登録に失敗しました。"
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path

  end

  private
  def address_params
    params.require(:address).permit(:name, :postal_code, :address, :customer_id)
  end

end
