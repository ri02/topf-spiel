class GamesController < ApplicationController
  before_action :set_game, only: [:show, :update]
  before_action :set_counter, only: [:show]

  def index
    @games = Game.all.order(created_at: :desc)
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to new_game_word_path(@game)
    else
      render :index
    end
  end

  def show
    @words_left = Word.where(game_id: params[:id]).where(status: true)
    @round = @game.round
    respond_to do |format|
       format.html
       format.json { render json: { words_left: @words_left, round: @round} }
    end
  end

  def update
    @game.increment!(:round)
    @words = Word.where(game_id: params[:id])
    @words.update(status: true)
    redirect_to game_path(@game)
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name, :number, :id, :players)
  end

  def set_counter
    @words_left = Word.where(game_id: params[:id]).where(status: true)
  end
end
