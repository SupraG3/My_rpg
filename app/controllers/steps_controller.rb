class StepsController < ApplicationController
  before_action :require_admin, except: [:show, :answer, :index]
  before_action :set_step, only: [:show, :edit, :update, :destroy, :answer]
  before_action :set_quest, only: [:new, :create, :edit, :update, :destroy, :answer, :show, :index]
  before_action :set_player, only: [:answer, :show]

  def index
    @steps = @quest.steps
  end

  def show
  end

  def new
    @step = Step.new
  end

  def edit
  end

  def create
    @step = Step.new(step_params)
    @step.quest = @quest

    if @step.save
      redirect_to @quest, notice: 'Step was successfully created.'
    else
      render :new
    end
  end

  def update
    if @step.update(step_params)
      redirect_to @quest, notice: 'Step was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @step.destroy
    redirect_to quest_steps_url(@quest), notice: 'Step was successfully destroyed.'
  end

  def answer
    if params[:answer] == @step.correct_answer
      flash[:notice] = 'Correct answer!'
      player = @player
      if @step.reward_item
        inventory_item = player.inventories.find_or_initialize_by(item: @step.reward_item)
        inventory_item.equipped = false
        inventory_item.save!
      end

      if @step.order == @step.quest.steps.count
        @step.quest.complete_quest(player)
        flash[:notice] = 'Quest completed! Congratulations!'
        redirect_to player_path(player)
      else
        next_step = @step.quest.steps.where(order: @step.order + 1).first
        redirect_to quest_step_path(@step.quest, next_step, player_id: player.id), notice: 'Step passed, you have obtained an item!'
      end
    else
      flash[:alert] = 'Wrong answer. Try again.'
      redirect_to quest_step_path(@step.quest, @step, player_id: @player.id)
    end
  end

  private

  def set_step
    @step = Step.find(params[:id])
  end

  def set_quest
    @quest = params[:quest_id] ? Quest.find(params[:quest_id]) : @step&.quest
  end

  def set_player
    @player = current_user.players.find(params[:player_id])
  end

  def step_params
    params.require(:step).permit(:description, :order, :quest_id, :question, :correct_answer, :wrong_answer, :reward_item_id)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: 'You do not have access to this page.'
    end
  end
end
