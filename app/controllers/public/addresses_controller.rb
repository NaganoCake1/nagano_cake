class Public::AddressesController < ApplicationController

  def index
    @addresses = Address.all
    @address_new = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to public_addresses_path(@address.id)
    else
      @addresses = Address.all
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to public_addresses_path
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    @addresses = Address.all
    render 'index'
  end

  private
  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end
