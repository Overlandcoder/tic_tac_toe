require_relative 'game.rb'
require_relative 'player.rb'

def play
  game = Game.new
  game.play_game
end

play
