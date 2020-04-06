class WordsController < ApplicationController

  def index
    @words = Word.where(game_id: params[:game_id]).where(status: true)
    @game = Game.find(params[:game_id])
    @word = @words.sample
  end

  def new
    @word = Word.new
    @game = Game.find(params[:game_id])
    @words = Word.where(game_id: params[:game_id])
    @total = @game.number * @game.players
    redirect_to game_path(@game) if @total == @words.count
  end

  def create
    @game = Game.find(params[:game_id])
    @words = Word.where(game_id: params[:game_id])
    @word = Word.new(word_params)
    @word.game_id = params[:game_id]
    @total = @game.number * @game.players
    if  @total > @words.count
      if @word.save
      redirect_to game_path(@game)
      else
      render :new
      end
    else
      redirect_to new_game_word_path(@game)
    end
  end



  def update
    @word = Word.find(word_params[:id])
    @game = Game.find(params[:game_id])
    @word.update(status: false)
    redirect_to game_words_path(@game)
  end


  private

  def word_params
    params.require(:word).permit(:text, :id)
  end
end
