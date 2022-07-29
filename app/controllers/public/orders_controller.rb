class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      redirect_to public_order_path
    else
      render 'new'
    end
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
    params.require(:order).permit(:customer_id, :payment_method, :postal_code, :address, :name, :postage, :status)
  end

end
