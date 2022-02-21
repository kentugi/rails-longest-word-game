require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a
    @randomarr = @letters.sample(10)
    @random = @randomarr.join(', ')
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    dictionary_serialized = URI.open(url).read
    dictionary = JSON.parse(dictionary_serialized)
    @randomarr = params['token'].split

    if dictionary['found'] == false
      @score = "Sorry, but #{params[:word]} doesnt' seem to be an English word"
    elsif !params[:word].upcase.split('').all? { |letter| @randomarr.include?(letter) }
      @score = "Sorry, but #{params[:word]} can't be out of #{@randomarr.join(', ')}"
    else
      @score = "Congrats! #{params[:word]} is a correct english word"
    end
  end
end
