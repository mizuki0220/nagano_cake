class Admin::CustomersController < ApplicationController
  layout 'admin'

  def index
    @customers = Customer.all
  end

  def show
  end

  def edit
  end

  def update
  end
end
