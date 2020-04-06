class GamesController < ApplicationController
  def index
    @games = Game.all
    @game = Game.new

  end

  def new
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
    @game = Game.find(params[:id])
    @words_left = Word.where(game_id: params[:id]).where(status: true)
  end

  def update
    @game = Game.find(params[:id])
    @words = Word.where(game_id: params[:id])
    @words.update(status: true)
    redirect_to game_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:name, :number, :id)
  end
end
