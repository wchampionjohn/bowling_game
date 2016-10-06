require 'rspec'
require_relative '../lib/bowling_game'
require 'byebug'

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

  it 'can calculate spacel' do
    game = Game.new
    game.roll 9
    game.roll 1
    game.roll 5
    expect(game.scope).to eq 20
  end

  it 'can calculate strike' do
    game = Game.new
    game.roll 10
    game.roll 5
    game.roll 4
    expect(game.scope).to eq 28
  end
end
