class InventoriesController < ApplicationController
    before_action :set_player
  
    def index
      @equipped_items = @player.equipped_items
      @available_items = @player.available_items
    end
  
    def equip_item
      item = Item.find(params[:item_id])
      @player.equip(item)
      redirect_to inventory_player_path(@player), notice: 'Item was successfully equipped.'
    end
  
    def unequip_item
      item = Item.find(params[:item_id])
      @player.unequip(item)
      redirect_to inventory_player_path(@player), notice: 'Item was successfully unequipped.'
    end
  
    private
  
    def set_player
      @player = current_user.players.find(params[:id])
    end
  end
  