class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @total = 0
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.save
    @cart_items = CartItem.all
    render 'index'
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :price,  :amount)
  end

end
