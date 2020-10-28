class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user
  def index
    @address = Address.new
    @addresses = current_user.addresses
  end

  def create
    @address = current_user.addresses.build(address_params)
    if @address.save
      redirect_to user_addresses_path(current_user), notice: 'created successfully'
    else
      @addresses = current_user.addresses.show_index
      render :index
    end
  end

  def destroy
    address = current_user.addresses.find(params[:id])
    if address.destroy
      redirect_to user_addresses_path(current_user), notice: 'deleted successfully'
    else
    end
  end

  private

  def address_params
    params.require(:address).permit(:address)
  end

  def correct_user
    user = User.find(params[:user_id])
    redirect_to dashboard_path unless user == current_user
  end
end
