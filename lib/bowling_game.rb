require_relative './frame'

class Game
  def initialize
    @frames = 10.times.inject([]) { |frames| frames << Frame.new }
    @frames.last.added_roll # 第10局預設有三次機會
  end

  def roll pins
    @frames[current_frame_index].regester_roll pins

    # 最後一局不是space或strike，就沒有第三次擊球機會
    if last_scope?
      @frames.last.delete_roll unless last_frame_strike_or_space?
    end
  end

  def scope
    completed_roll_frames.each_with_index.inject(0) do |sum, (frame,index)|
      sum += frame.scope
      sum += extra_pins(frame, index) # strke or space額外加分
    end
  end

  private
  def current_frame_index
    @frames.each_with_index do |frame, index|
      return index unless frame.completed?
    end

    9
  end

  def current_times_index
    @frames[current_frame_index].index(nil)
  end

  # 有擊球的局數
  def completed_roll_frames
    @frames.each_with_object([]) do |frame, result|
      result << frame if frame.has_rolls?
    end
  end

  def extra_pins(frame, frame_index)
    return 0 if frame_index == 9 # 第10局不額外加分
    if frame.strike?
      next_frames = @frames[frame_index+1..frame_index+2]
      next_rolls = next_frames.map { |frame| frame.rolls }.flatten.compact # 下兩局的擊球分數
      next_rolls[0].to_i + next_rolls[1].to_i # 下兩次擊球的分數總和
    elsif frame.space?
      @frames[frame_index+1].rolls.first # 下一次擊球分數
    else
      0
    end
  end

  # 是否完成了最後一局的前兩次擊球?
  def last_scope?
    !@frames.last.rolls[1].nil?
  end

  def last_frame_strike_or_space?
    @frames.last.space? || @frames.last.strike?
  end
end
