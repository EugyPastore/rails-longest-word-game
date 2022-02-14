require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    #The new action will be used to display a new random grid and a form
    @letters = ('a'..'z').to_a.shuffle.first(10)
  end

  def score
    # will be submitted (with POST) to the score action
    input = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    user_serialized = URI.open(url).read
    dictionary = JSON.parse(user_serialized)


    if dictionary["found"] && input.chars.all? { |letter| input.count(letter) <= params[:letters].split(' ').count(letter) }

      @score = "Congratulations! #{params[:word]} is valid English word!"

    elsif !dictionary["found"]
    #params[:word] NOT built with given letters
    @score = "Sorry! but #{input} does not seem to be an English word"

    elsif !dictionary["found"] && input.chars.all? do |letter|
      input.count(letter) <= params[:letters].split(' ').count(letter)
      end
      @score = "Sorry! But #{input} is not built by #{params[:letters]}!"
      #params[:word] do not exist in dictionary && built from given letters
    end
  end
end
