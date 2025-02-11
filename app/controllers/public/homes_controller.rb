class Public::HomesController < ApplicationController
  def top
    @items = Item.where(is_saled: true).order(created_at: "DESC").limit(4)
  end
end
