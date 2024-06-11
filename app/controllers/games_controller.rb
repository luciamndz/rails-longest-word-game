require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @include_letters = include_letters?(@letters, @word) # devuelve true or false. si es true -> valid word?
    @valid_word = valid_word?(@word)
    # devuelve true of false. si es true -> muestra felicitacion
  end

  private

  def include_letters?(letters, word) #verifica que la palabra esté incluída en letters
    word_arr = word.upcase.chars # returns an array of characters
    word_arr.all? { |letter| word_arr.count(letter) <= letters.count(letter)}
    # .all? pasa cada letra del array word_at, regresa true si el boque no regresa false o nill
    # .count cuenta el numero de veces que está una letra en word_att  en letter
  end

  def valid_word?(word) #valida que la palabra sea una english word
    word = JSON.parse(URI.open("https://dictionary.lewagon.com/#{word}").read)
    word["found"] #regresa true or false

  end
end
