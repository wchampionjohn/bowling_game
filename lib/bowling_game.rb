class Game
  def initialize
    @frames = 9.times.inject([]) { |frames| frames << [nil, nil] }
    @frames << [nil, nil, nil] # 第10局預設有三次機會
  end

  def roll points
    frames_index = current_frame_index
    times_index = current_times_index

    @frames[frames_index][times_index] = points

    # 最後一局前兩次加起來沒有超過10分，就沒有第三次擊球機會
    if frames_index == 9 && times_index == 1
      @frames[frames_index].pop if @frames[frames_index][0..1].reduce(:+) < 10
    end
  end

  def scope
    completed_rolls.each_with_index.inject(0) do |sum, (frame,index)|
      sum += frame.compact.reduce(:+)

      sum += if strike? frame
               next_rolls = completed_rolls[index+1..index+2].flatten.compact # 下兩局的擊球分數
               next_rolls[0].to_i + next_rolls[1].to_i # 下兩次擊球的總和
             elsif space? frame
               completed_rolls[index + 1].first
             else
               0
             end
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

  def space? frame
    frame.first != 10 && frame.compact.reduce(:+) == 10
  end

  def strike? frame
    frame.first == 10
  end
end
