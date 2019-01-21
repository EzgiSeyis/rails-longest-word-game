require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:grid]

    if included?(@word.upcase, @letters)
      if english_word?(@word)
        @answer = "Congratulations! #{@word.upcase} is a valid English word!"
      else
        @answer = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
      end
    else
      @answer = "Sorry but #{@word.upcase} cant be built out of #{@letters}"
    end
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end

    # @word = params[:word]
    # if english_word?(@word)
    #   @answer = "Congratulations! #{@word} is a valid English word!"
    # elsif @answer = "Sorry but #{@word} does not seem to be a valid English word..."
    # end

    # @letters = params[:grid]
    # if included?(@word.upcase, @letters)
    #   @ans = 'richtig'
    # elsif
    #   @ans = 'falsch'
    # end
