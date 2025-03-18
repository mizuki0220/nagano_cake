class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, only: [:show, :edit, :withdraw]

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "編集が完了しました。"
      redirect_to customers_my_page_path
    else
      flash[:alert] = "登録に失敗しました。"
      render :edit
    end
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :encrypted_password, :postal_code, :address, :telephone_number, :is_active)
    end

    def authenticate_customer!
      unless current_customer
        redirect_to new_customer_session_path, alert: "ログインしてください"
      end
    end

end
