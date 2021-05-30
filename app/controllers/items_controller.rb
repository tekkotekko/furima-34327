class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :find_item_by_id, only: [:show, :edit, :update]
  before_action :item_of_current_user?, only: [:edit, :update]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      render action: :show
    else
      render action: :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :image, :description, :category_id, :condition_id, :charge_id, :prefecture_id, :day_id,
                                 :price).merge(user_id: current_user.id)
  end

  def find_item_by_id
    @item = Item.find(params[:id])
  end

  def item_of_current_user?
    redirect_to root_path if current_user != @item.user
  end
end
