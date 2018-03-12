require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    # generate letter grid
    @grid = []
    10.times do
      sample_array = [*('A'..'Z')].sample(1)
      @grid << sample_array[0]
    end
    @grid
  end

  def score
    @answer = params[:answer]
    @tirage = params[:grid]
    @score = run_game(@answer, @tirage)
  end

  def run_game(answer, tirage)
    # TODO: runs the game and return detailed hash of result
    word = JSON.parse(open('https://wagon-dictionary.herokuapp.com/' + answer).read)
    failed = 0
    tirage = tirage.delete(' ').chars
    answer.upcase.split('').each { |x| tirage.index(x).nil? ? failed += 1 : tirage.delete_at(tirage.index(x)) }

    # calculate score
    if failed > 0
      { score: 0, message: 'Your answer is not in the grid', total: SCORE }
    elsif word['found'] == false
      { score: 0, message: "Sorry but #{answer} doesn' seems to be an english word" , total: SCORE }
    else
      { score: answer.length, message: 'well done' , total: SCORE + answer.length }
    end

  end

end
