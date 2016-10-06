class Game
  def initialize
    @frames = 10.times.inject([]) { |frames| frames << [nil, nil] }
  end

  def roll points
    if current_frame_index == 9 # 第十局strike或space額外增加局數
      @frames << [nil, nil] if points == 10
      @frames << [nil] if (@frames[current_frame_index].first.to_i + points == 10)
    end

    @frames[current_frame_index][current_times_index] = points
  end

  def scope
    regular_frames.each_with_index.inject(0) do |sum, (frame,index)|
      sum += frame.compact.reduce(:+)

      sum += if strike? frame
               next_rolls = completed_rolls[index+1..index+2].flatten # 下兩局的擊球分數
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
      return index if frame.include?(nil) && (frame.first != 10)
    end
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

  # 正規10局有擊球局數
  def regular_frames
    completed_rolls[0..9]
  end

  def space? frame
    frame.first != 10 && frame.compact.reduce(:+) == 10
  end

  def strike? frame
    frame.first == 10
  end
end
