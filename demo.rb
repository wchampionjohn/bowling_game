require './lib/bowling_game'

game = Game.new
game2 = Game.new

12.times { game.roll 10 }
puts game.scope

20.times { game2.roll 3 }
puts game2.scope
