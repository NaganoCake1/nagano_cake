class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = CartItem.all
    @item = Item.all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id

    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.amount += params[:cart_item][:amount].to_i
    @cart_item.save
    redirect_to cart_items_path

    elsif @cart_item.save
      @cart_items = CartItem.all
      render 'index'
    else
      @cart_items = CartItem.all
      render 'index'
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    @cart_items = CartItem.all
    render 'index'
  end

  def destroy_all
    @cart_items = CartItem.all
    @cart_items.destroy_all
    render 'index'
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:image, :item_id, :price, :amount)
  end

end
