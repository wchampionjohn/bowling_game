require 'rspec'
require_relative '../lib/bowling_game'

describe 'Bowling Game' do
  it 'can create game' do
    Game.new
  end
end
