require './lib/bowling_game'
require 'byebug'

game = Game.new
game2 = Game.new

12.times { game.roll 10 }
puts game.print
puts game.scope

20.times { game2.roll 3 }
puts game2.scope
