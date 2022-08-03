class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def check #注文情報確認画面
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    p @order #idなどを出力できる
    if params[:order][:address_option] == "0"
     @order.postal_code = current_customer.postal_code
     @order.address = current_customer.address
     @order.name = current_customer.first_name + current_customer.last_name

    elsif params[:order][:address_option] == "1"
      @address = Address.find(params[:order][:address_id])
     #配送先(Address)モデルから送られてきた ID をもとに取得
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    # 新規住所入力 [:address_option]=="2"としてデータをhtmlから受ける
    elsif params[:oerder][:address_option] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:prder][:name]

    else
      render 'new'
    end
    @cart_items = current_customer.cart_items.all

  end

  def comfilm
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id#商品idを注文詳細idに代入
      @order_detail.amount = cart_item.amount#商品の個数を注文詳細に代入
      @order_detail.tax_included_plrice = cart_item.item.with_tax_price#消費税込みの値段
      @order_detail.order_id = @order.id #商品詳細に注文IDを紐付け
      @order_detail.save
    end

    current_customer.cart_items.destroy_all
    redirect_to public_orders_complete_path

  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def histry
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :postal_code, :address, :name, :postage, :total, :status)
  end

end
