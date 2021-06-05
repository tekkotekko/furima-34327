class PurchaseLogsController < ApplicationController

  def index
    @item=Item.find(params[:item_id])
    @purchase_log=PurchaseLog.new
  end

end
