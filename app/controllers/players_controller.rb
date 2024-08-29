class PlayersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_player, only: [:show, :edit, :update, :destroy, :inventory, :equip_item, :unequip_item, :level_up, :allocate_points]
  before_action :require_admin, only: [:view_all]

  def index
    @players = current_user.players
  end

  def show
  end

  def new
    @player = current_user.players.build
  end

  def edit
  end

  def create
    @player = current_user.players.build(player_params)
    if @player.save
      redirect_to @player, notice: 'Player was successfully created.'
    else
      render :new
    end
  end

  def update
    if @player.update(player_params)
      if current_user.admin?
        redirect_to view_all_players_path, notice: 'Player was successfully updated.'
      else
        redirect_to @player, notice: 'Player was successfully updated.'
      end
    else
      render :edit
    end
  end

  def destroy
    @player.destroy
    if current_user.admin?
      redirect_to view_all_players_path, notice: 'Player was successfully destroyed.'
    else
      redirect_to players_url, notice: 'Player was successfully destroyed.'
    end
  end

  def inventory
    @items = @player.items
  end

  def equip_item
    player_item = @player.inventories.find_by(item_id: params[:item_id])
    if player_item
      player_item.update(equipped: true)
      redirect_to inventory_player_path(@player), notice: 'Item was successfully equipped.'
    else
      redirect_to inventory_player_path(@player), alert: 'Item not found.'
    end
  end

  def unequip_item
    player_item = @player.inventories.find_by(item_id: params[:item_id])
    if player_item
      player_item.update(equipped: false)
      redirect_to inventory_player_path(@player), notice: 'Item was successfully unequipped.'
    else
      redirect_to inventory_player_path(@player), alert: 'Item not found.'
    end
  end

  def level_up
    @player.level_up
    redirect_to @player, notice: 'Player leveled up.'
  end

  def allocate_points
    health_points = params[:health_points].to_i
    strength_points = params[:strength_points].to_i

    if @player.allocate_points(health_points, strength_points)
      redirect_to @player, notice: 'Points successfully allocated.'
    else
      redirect_to @player, alert: 'Failed to allocate points.'
    end
  end

  def view_all
    @users = User.includes(:players).all
  end

  private

  def set_player
    if current_user.admin?
      @player = Player.find(params[:id])
    else
      @player = current_user.players.find(params[:id])
    end
  end

  def player_params
    params.require(:player).permit(:name)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: 'You do not have access to this page.'
    end
  end
end
