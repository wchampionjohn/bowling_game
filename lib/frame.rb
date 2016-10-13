class Frame
  attr_reader :rolls
  attr_reader :num

  def initialize num
    @rolls = [nil, nil]
    @num = num
    @rolls << nil if last?
  end

  def regester_roll pins
    @rolls[@rolls.index(nil)] = pins

    if last_and_second_rolls?
      @rolls[2] = false if !strike? && !space?
    end
  end

  def scope
    @rolls.delete_if { |roll| !roll }.reduce(:+)
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
    !@rolls[0].nil?
  end

  def last?
    @num == 10
  end

  def last_and_second_rolls?
    last? && (!@rolls[1].nil? && @rolls[2].nil?)
  end
end
