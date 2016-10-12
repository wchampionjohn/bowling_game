class Frame
  attr_reader :rolls

  def initialize
    @rolls = [nil, nil]
  end

  def added_roll
    @rolls << nil
  end

  def delete_roll
    @rolls.pop
  end

  def regester_roll pins
    @rolls[@rolls.index(nil)] = pins
  end

  def scope
    @rolls.compact.reduce(:+)
  end

  def strike?
    @rolls.first == 10
  end

  def space?
    @rolls[0].to_i + @rolls[1].to_i == 10
  end

  def completed?
    strike? || ! @rolls.include?(nil)
  end

  def has_rolls?
    @rolls[0].to_i + @rolls[1].to_i > 0
  end
end
