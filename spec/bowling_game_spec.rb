require 'rspec'
require_relative '../lib/bowling_game'
require 'byebug'

describe 'Bowling Game' do
  let(:game) { Game.new }
  it 'can create game' do
  end

  it 'can roll' do
    game.roll 6
  end

  it 'can calculate scope' do
    20.times { game.roll 3 }
    expect(game.scope).to eq 60
  end

  it 'can extra append points if roll spacel' do
    game.roll 9
    game.roll 1
    game.roll 5
    expect(game.scope).to eq 20 # 15 + 5
  end

  it 'can extra append points if roll strike' do
    game.roll 10
    game.roll 5
    game.roll 4
    expect(game.scope).to eq 28 # 19 + 9
  end

  it 'can extra append two times roll if last frame is strike' do
    18.times { game.roll 4 }
    game.roll 10
    game.roll 5
    game.roll 4
    expect(game.scope).to eq 91 # 72 + 19
  end


  it 'can extra append one times roll if last frame is space' do
    18.times { game.roll 4 }
    game.roll 5
    game.roll 5
    game.roll 4
    expect(game.scope).to eq 86 # 72 + 14
  end

  it 'can roll a Turkey' do
    3.times { game.roll 10 }
    2.times { game.roll 1 }
    expect(game.scope).to eq 65 # 30 + 21 + 12 + 2
  end

  it 'can roll a perfact game' do
    12.times { game.roll 10 }
    expect(game.scope).to eq 300
  end
end
