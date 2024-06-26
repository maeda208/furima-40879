class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_item, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_address = OrderAddress.new
    if @item.order.present?
      redirect_to root_path
      return
    end
    return unless current_user.id == @item.user_id

    redirect_to root_path
  end

  def create
    @order_address = OrderAddress.new(order_params)
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render 'orders/index'
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :municipalities, :address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
