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

  it 'ofter last frame can add two times if last frame is strike' do
    game = Game.new
    18.times { game.roll 4 }
    game.roll 10
    game.roll 5
    game.roll 4
    expect(game.scope).to eq 91
  end


  it 'ofter last frame can add two times if last frame is strike' do
    game = Game.new
    18.times { game.roll 4 }
    game.roll 5
    game.roll 5
    game.roll 4
    expect(game.scope).to eq 86 # 72 + 14
  end

  it 'can roll Turkey' do
    game = Game.new
    3.times { game.roll 10 }
    2.times { game.roll 1 }
    expect(game.scope).to eq 65 # 30 + 21 + 12 + 2
  end

  it 'can roll a perfact game' do
    game = Game.new
    12.times { game.roll 10 }
    expect(game.scope).to eq 300
  end
end
