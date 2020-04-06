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
    @i = (1..@game.number).to_a
    redirect_to game_path(@game) if @total == @words.count
  end

  def create
    @game = Game.find(params[:game_id])
    @words = Word.where(game_id: params[:game_id])
    word_params[:text].each do |word|
      @word = Word.new(text: word)
      @word.game_id = params[:game_id]
      @total = @game.number * @game.players


        if @word.save

        else
        render :new
        end
    end
    redirect_to game_path(@game)
  end



  def update
    @word = Word.find(word_params[:id])
    @game = Game.find(params[:game_id])
    @word.update(status: false)
    redirect_to game_words_path(@game)
  end


  private

  def word_params
    params.require(:word).permit(:id, text:[])
  end
end
