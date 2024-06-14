class ItemsController < ApplicationController
  before_action :authenticate_user!, only:[:new]
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path @item
      else
      render :new, status: :unprocessable_entity
  end
end
  private
  def item_params
    params.require(:item).permit(:image, :product_name, :product_description, :category_id, :condition_id, :contribution_id, :prefecture_id, :day_id, :price).merge(user_id: current_user.id)
  end
end
