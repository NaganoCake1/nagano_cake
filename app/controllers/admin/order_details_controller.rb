class Admin::OrderDetailsController < ApplicationController
  def show
    @order_details = OrderDetails.find(params[:id])
  end
end
