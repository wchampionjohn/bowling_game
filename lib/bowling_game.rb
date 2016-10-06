class Game
  def initialize
    @rolls = 10.times.inject([]) { |rolls| rolls << [nil, nil] }
  end
  def roll points
    @rolls[current_frame_index][current_times_index] = points
  end

  def scope
    completed_rolls.each_with_index.inject(0) do |sum, (frame,index)|
      frame_sum = frame.compact.reduce(:+)

      sum += frame_sum
      sum += completed_rolls[index + 1].first if (frame_sum == 10)

      sum
    end
  end

  private
  def current_frame_index
    @rolls.each_with_index do |frame, index|
      return index if (frame.include?(nil)) && (frame.first != 10)
    end
  end

  def current_times_index
    @rolls[current_frame_index].index(nil)
  end

  def completed_rolls
    @rolls.each_with_object([]) do |frame, result|
      result << frame unless frame.compact.empty?
    end
  end
end
