class Public::OrdersController < ApplicationController
  def new
    @order_new = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    redirect_to public_order_path
  end

  def show
    @order = Order.find(params[:id])
  end

  def complete
  end

  def index
  end

  def histry
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :status)
  end

end
