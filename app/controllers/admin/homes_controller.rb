class Admin::HomesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
end
