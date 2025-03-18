class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "編集が完了しました。"
      redirect_to admin_customer_path(@customer)
    else
      flash[:alert] = "登録に失敗しました。"
      render :edit
    end

  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_active)
  end
end
