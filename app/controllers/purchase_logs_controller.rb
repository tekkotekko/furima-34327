class PurchaseLogsController < ApplicationController

  def index
    @item=Item.find(params[:id])
    @purchase_log=Purchase_log.new
  end

end
