class Game
  def initialize
    @rolls = 10.times.inject([]) { |rolls| rolls << [nil, nil] }
  end

  def roll points
    @rolls[current_frame_index][current_times_index] = points
  end

  def scope
    completed_rolls.each_with_index.inject(0) do |sum, (frame,index)|
      sum += frame.compact.reduce(:+)

      sum += if strike? frame
               after_rolls = completed_rolls[index+1..index+2].flatten # 下兩局的分數
               after_rolls[0] + after_rolls[1] # 下兩次的總和
             elsif space? frame
               completed_rolls[index + 1].first
             else
               0
             end
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

  def space? frame
    frame.first != 10 && frame.compact.reduce(:+) == 10
  end

  def strike? frame
    frame.first == 10
  end
end
