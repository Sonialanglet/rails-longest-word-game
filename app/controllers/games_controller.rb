require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters =[*('A'..'Z')].sample(10)
  end


  def score
    @word = params[:word]
    @letters = params[:letters].split("")

      if is_in_grid?
      if translation?
       @result = "well done"
    else
       @result = "not an english word"
        end
      else
       @result = "not in the grid"
      end
    end



    def translation?
      url = "https://wagon-dictionary.herokuapp.com/#{@word}"
      word_serialized = open(url).read
      word_info = JSON.parse(word_serialized)
      return word_info['found']
    end

    def is_in_grid?
      @word.upcase.split("").all? do |letter|
      @word.count(letter) <= @letters.count(letter)
      end
    end

end

