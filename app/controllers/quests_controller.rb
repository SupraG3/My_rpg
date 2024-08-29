class QuestsController < ApplicationController
  before_action :require_admin, except: [:index, :show, :start_quest]
  before_action :set_quest, only: [:show, :edit, :update, :destroy, :start_quest]
  before_action :set_player, only: [:index, :show, :start_quest]

  def index
    @quests = Quest.all
  end

  def show
  end

  def new
    @quest = Quest.new
  end

  def edit
  end

  def create
    @quest = Quest.new(quest_params)

    if @quest.save
      redirect_to @quest, notice: 'Quest was successfully created.'
    else
      render :new
    end
  end

  def update
    if @quest.update(quest_params)
      redirect_to @quest, notice: 'Quest was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @quest.destroy
    redirect_to quests_url, notice: 'Quest was successfully destroyed.'
  end

  def start_quest
    first_step = @quest.steps.order(:order).first
    if first_step
      redirect_to quest_step_path(@quest, first_step, player_id: @player.id)
    else
      redirect_to quests_path, alert: 'This quest has no steps.'
    end
  end

  private

  def set_quest
    @quest = Quest.find(params[:id])
  end

  def set_player
    if current_user.admin?
      @player = current_user.players.first
    elsif params[:player_id]
      @player = current_user.players.find(params[:player_id])
    else
      @player = current_user.players.first
    end
  end

  def quest_params
    params.require(:quest).permit(:name, :description)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: 'You do not have access to this page.'
    end
  end
end
