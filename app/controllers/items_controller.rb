class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_item, only: [:edit, :show, :update, :destroy]
  before_action :user_signed, only: [:edit, :destroy]
  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def show
  end

  def edit
    if @item.order.present?
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path @item
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def user_signed
    return if current_user.id == @item.user_id

    redirect_to action: :index
  end

  def item_params
    params.require(:item).permit(:image, :product_name, :product_description, :category_id, :condition_id, :contribution_id,
                                 :prefecture_id, :day_id, :price).merge(user_id: current_user.id)
  end
end
