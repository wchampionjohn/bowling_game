class Game
  def initialize
    @frames = 9.times.inject([]) { |frames| frames << [nil, nil] }
    @frames << [nil, nil, nil] # 第10局預設有三次機會
  end

  def roll points
    @frames[current_frame_index][current_times_index] = points

    # 最後一局不是space或strike，就沒有第三次擊球機會
    if finished_last_frame_and_second_roll?
      @frames[9].pop unless last_frame_strike_or_space?
    end
  end

  def scope
    completed_rolls.each_with_index.inject(0) do |sum, (frame,index)|
      sum += frame.compact.reduce(:+)
      sum += extra_points(frame, index) # strke or space額外加分
    end
  end

  private
  def current_frame_index
    @frames.each_with_index do |frame, index|
      return index if frame.include?(nil) && !strike?(frame)
    end

    9
  end

  def current_times_index
    @frames[current_frame_index].index(nil)
  end

  # 有擊球局數
  def completed_rolls
    @frames.each_with_object([]) do |frame, result|
      result << frame unless frame.compact.empty?
    end
  end

  def extra_points(frame, frame_index)
    return 0 if frame_index == 9 # 第10局不額外加分
    if strike? frame
      next_rolls = completed_rolls[frame_index+1..frame_index+2].flatten.compact # 下兩局的擊球分數
      next_rolls[0].to_i + next_rolls[1].to_i # 下兩次擊球的分數總和
    elsif space? frame
      completed_rolls[frame_index + 1].first # 下一次擊球分數
    else
      0
    end
  end

  def space? frame
    frame.first != 10 && frame.compact.reduce(:+) == 10
  end

  def strike? frame
    frame.first == 10
  end

  # 是否完成了最後一局的前兩次擊球?
  def finished_last_frame_and_second_roll?
    !@frames[9][1].nil? && @frames[9][2].nil?
  end

  def last_frame_strike_or_space?
    space?(last_frame) || strike?(last_frame)
  end

  def last_frame
    @frames[9]
  end
end
