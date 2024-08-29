class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin, only: [:view_all, :new, :create, :edit, :update, :destroy, :show]

  def show
    @item = Item.find(params[:id])
  end

  def view_all
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to view_all_items_path, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to view_all_items_path, notice: 'Item was successfully destroyed.'
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :health_bonus, :strength_bonus, :item_type, :image)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: 'You do not have access to this page.'
    end
  end
end
