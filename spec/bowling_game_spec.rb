require 'rspec'
require_relative '../lib/bowling_game'

describe 'Bowling Game' do
  it 'can create game' do
    Game.new
  end

  it 'can roll' do
    game = Game.new
    game.roll 10
  end

  it 'can calculate scope' do
    game = Game.new
    20.times { game.roll 3 }
    expect(game.scope).to eq 60
  end
end
