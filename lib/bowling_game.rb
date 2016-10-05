class Game
  def initialize
    @rolls = 10.times.inject([]) { |rolls| rolls << [nil, nil] }
  end
  def roll points
    @rolls[current_frame_index][current_times_index] = points
  end

  def scope
    @rolls.inject(0) do |sum, frame|
      sum += frame.reduce(:+)
    end
  end

  def current_frame_index
    @rolls.each_with_index do |frame, index|
      return index if (frame.include?(nil)) && (frame.first != 10)
    end
  end

  def current_times_index
    @rolls[current_frame_index].index(nil)
  end
end
