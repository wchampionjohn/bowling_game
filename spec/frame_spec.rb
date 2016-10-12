require 'rspec'
require_relative '../lib/frame'
require 'byebug'

describe 'Bowling Game Frame' do
  let(:frame) { Frame.new }

  it 'can create new frame' do
    Frame.new
  end

  it 'can additional times' do
    frame.added_roll
  end

  it 'can regester pins' do
    frame.regester_roll 2
  end

  it 'can calculate scope' do
    frame.regester_roll 2
    frame.regester_roll 5
    frame.scope
    expect(frame.scope).to eq 7
  end

  it 'can check is strike?' do
    frame.regester_roll 5
    frame.regester_roll 2
    expect(frame.strike?).to be false
    frame2 = Frame.new
    frame2.regester_roll 10
    expect(frame2.strike?).to be true
  end


  it 'can check is space?' do
    frame.regester_roll 5
    frame.regester_roll 2
    expect(frame.space?).to be false
    frame2 = Frame.new
    frame2.regester_roll 5
    frame2.regester_roll 5
    expect(frame2.space?).to be true
  end

  it 'can check is completed?' do
    expect(frame.completed?).to be false
    frame.regester_roll 5
    expect(frame.completed?).to be false
    frame.regester_roll 2
    expect(frame.completed?).to be true
  end

  it 'can check has rolls?' do
    expect(frame.has_rolls?).to be false
    frame.regester_roll 5
    expect(frame.has_rolls?).to be true
  end

end
