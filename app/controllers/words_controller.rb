class WordsController < ApplicationController
  before_action :set_game
  before_action :set_words , only: [:new, :create]
  before_action :set_description , only: [:index]


  def index
    @words = Word.where(game_id: params[:game_id]).where(status: true)
    @word = @words.sample
  end

  def new
    redirect_to game_path(@game) if (@game.number * @game.players) <= @words.count
    @word = Word.new
  end

  def create
    if word_params[:text].length > word_validation
     render :new
    elsif (@game.number * @game.players) <= @words.count
      redirect_to game_path(@game)
    else
      word_params[:text].each do |word|
        @word = Word.new(text: word, game_id: params[:game_id])
        @word.save
      end
      redirect_to game_path(@game)
    end
  end

  def update
    @word = Word.find(word_params[:id])
    @word.update(status: false)
    @game.groupname == 'a' ? @game.increment!(:counter_a) : @game.increment!(:counter_b)
    redirect_to game_words_path(@game)
  end


  private

  def word_validation
    i = 0
    word_params[:text].each do |word|
      @word = Word.new(text: word, game_id: params[:game_id])
      i += 1 if @word.valid?
    end
    i
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_words
    @words = Word.where(game_id: params[:game_id])
  end

  def word_params
    params.require(:word).permit(:id, text:[])
  end

  def set_description
    case @game.round
     when 1
      @description = 'Erklären den folgenden Bergiff'
     when 2
      @description = 'Stelle den folgenden Bergiff panthomimisch dar'
     when 3
      @description = 'Du darfst den folgenden Begriff mit einem Wort beschreiben. Das Wort darf nicht mehr geändert werden'
     when 4
      @description = 'Beschreibe den Begriff mit (verschiedenen) Geräuschen'
     else
      @description = 'Spiel beendet'
    end
  end
end
