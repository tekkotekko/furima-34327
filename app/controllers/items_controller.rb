class ItemsController < ApplicationController
  before_action :redirect_to_login, only: :new

  def index
  end

  def new
    @item=Item.new
  end

  def create
    @item=Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :description, :category_id, :condition_id, :charge_id, :prefecture_id, :day_id, :price).merge(user_id: current_user.id)
  end

  def redirect_to_login
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
