class PurchaseLogsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :find_item_by_id, only: [:index, :create]
  before_action :redirect_to_root_path, if: -> { current_user == @item.user || !@item.purchase_log.nil? }, only: [:index, :create]

  def index
    @purchase_log_address = PurchaseLogAddress.new
  end

  def create
    @purchase_log_address = PurchaseLogAddress.new(purchase_log_address_params)
    if @purchase_log_address.valid?
      pay_item
      @purchase_log_address.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def find_item_by_id
    @item = Item.find(params[:item_id])
  end

  def purchase_log_address_params
    params.require(:purchase_log_address).permit(:postal_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_log_address_params[:token],
      currency: 'jpy'
    )
  end

  def redirect_to_root_path
    redirect_to root_path
  end
end
