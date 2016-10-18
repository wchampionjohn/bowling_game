require 'rspec'
require_relative '../lib/bowling_game'
require_relative '../lib/Exceptions'
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

  context 'can calculate print game result' do
    it 'can show every frame scope' do
      expected_game_result = " 1   2   3   4   5   6   7   8   9   10  \n3 3|3 3|3 3|3 3|3 3|3 3|3 3|3 3|3 3|3 3  | 60"
      20.times { game.roll 3 }
      expect(game.game_result).to eq expected_game_result
    end

    it 'can show X string if frame is strke' do
      expected_game_result = " 1   2   3   4   5   6   7   8   9   10  \nX  |3 3|3 3|3 3|3 3|3 3|3 3|3 3|3 3|3 3  | 70"
      game.roll 10
      18.times { game.roll 3 }
      expect(game.game_result).to eq expected_game_result
    end

    it 'can show  if three strikes bowled consecutively' do
      expected_game_result = " 1   2   3   4   5   6   7   8   9   10  \n  |  |  |3 3|3 3|3 3|3 3|3 3|3 3|3 3  | 111"
      game.roll 10
      game.roll 10
      game.roll 10
      14.times { game.roll 3 }
      expect(game.game_result).to eq expected_game_result
    end
  end

  context 'excetptions' do
    it 'should be raise RollException if roll game already finish' do
      expect(game.finish?).to be false
      20.times { game.roll 1 }
      expect(game.finish?).to be true
      expect { game.roll 1 }.to raise_error(Exceptions::RollException)
    end

    it 'should be raise RollPinsNotValid if roll pin < 0 or > 10' do
      expect { game.roll -1 }.to raise_error(Exceptions::RollPinsNotValid)
      expect { game.roll 11 }.to raise_error(Exceptions::RollPinsNotValid)
      expect { game.roll 15 }.to raise_error(Exceptions::RollPinsNotValid)
    end

    it 'should be raise OverRemaingPins if pins_more_than_remaining_pins' do
      game.roll 5
      expect { game.roll 6 }.to raise_error(Exceptions::OverRemaingPins)

      game2 = Game.new
      game2.roll 9
      expect { game2.roll 9 }.to raise_error(Exceptions::OverRemaingPins)
    end
  end
end
