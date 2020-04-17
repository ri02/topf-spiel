class GamesController < ApplicationController
  before_action :set_game, only: [:show, :update, :timer]
  before_action :set_words_left, only: [:show, :update]
  before_action :set_game_round_description, only: [:show]


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
    @check = ((@game.number * @game.players) > @game.words.count) ? 'Wartet! Mitspielerberiffe fehlen noch!' : ""
    respond_to do |format|
       format.html
       format.json { render json: { words_left: @words_left, round: @game_round_description, counter_a: @game.counter_a, counter_b: @game.counter_b, check: @check} }
    end
  end

  def update
    if game_params[:groupname] == 'c'
     @game.increment!(:round)
     @words = Word.where(game_id: params[:id])
     @words.update(status: true)
     redirect_to game_path(@game)
    else
      @game.update(groupname: game_params[:groupname])
      redirect_to game_words_path(@game)
    end
  end

  def timer
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:name, :number, :id, :players, :groupname)
  end

  def set_words_left
    @words_left = Word.where(game_id: params[:id]).where(status: true)
  end

  def set_game_round_description
    case @game.round
     when 1
      @game_round_description = 'Erklären'
     when 2
      @game_round_description = 'Panthomime'
     when 3
      @game_round_description = 'Ein Wort'
     when 4
      @game_round_description = 'Geräusche'
     else
      @game_round_description = 'Spielende'
    end
  end
end
