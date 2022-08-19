class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details


    if @order.status == "入金確認"
      @order_details.update_all(making_status: "制作待ち")
    end

    redirect_to admin_order_path(@order)
  end

  private
    def order_params
      params.require(:order).permit(:status)
    end
end


