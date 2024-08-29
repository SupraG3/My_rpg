class BattlesController < ApplicationController
  before_action :set_battle, only: [:show, :attack]

  def show
  end

  def create
    @quest = Quest.find(params[:quest_id])
    @player = current_user.players.find(params[:player_id])
    @battle = Battle.create(player: @player, quest: @quest)
    redirect_to battle_path(@battle, player_id: @player.id)
  end

  def attack
    @player = @battle.player
    if @battle.current_turn.odd?
      @battle.player_attack
    else
      @battle.opponent_attack
    end
    redirect_to battle_path(@battle, player_id: @player.id)
  end

  private

  def set_battle
    @battle = Battle.find(params[:id])
  end
end
