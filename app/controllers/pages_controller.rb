require 'open-uri'
require 'json'

class PagesController < ApplicationController
  def play
    @random_letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @random_letters = params[:random_letters]
    @result = "You didn't use the right letters!"
    if included?(@word, @random_letters)
      if real_word?(@word)
        @result = "Well done, that's a real word!"
        else
        @result = "Sorry that isn't a real world!"
      end
    else
      @result = "Those aren't the right letters!"
    end
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def real_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
