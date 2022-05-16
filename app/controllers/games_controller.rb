require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].sample(10)
  end

  def score
    @letters = [*('A'..'Z')].sample(10)
    @letters = params[:letters]
    @answer = params[:answer]
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    serialized_words = URI.open(url).read
    words = JSON.parse(serialized_words)
    word = words['found']
    @score = if word && @answer.split(//).each { |letter| @letters.include?(letter) }
               'Good Word!!!!'
             elsif word == false && @answer.split(//).each { |letter| @letters.include?(letter) }
               'Your word does not exist...'
             else
               'Try with the asked letters !'
             end
  end
end
