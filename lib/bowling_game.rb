require_relative './frame'

class Game
  def initialize
    @frames = 10.times.inject([]) do |result ,num|
      result << Frame.new(num + 1)
    end
  end

  def roll pins
    @frames[current_frame_index].regester_roll pins
  end

  def scope
    completed_roll_frames.each.inject(0) do |sum, frame|
      sum += frame.scope
      sum += extra_pins(frame) # strke or space額外加分
    end
  end

  def game_result
    result = ''
    result << header + "\n"
    @frames.inject(result) { |result, frame|
      result << frame.rolls.inject([]) do |r, roll|
        r << if !roll
               ' '
             elsif frame.strike?
               'X'
             else
               roll
             end
      end.join(' ')

      result << '|'
    }
    result + ' ' + scope.to_s
  end

  private
  def current_frame_index
    @frames.each_with_index do |frame, index|
      return index unless frame.completed?
    end

    9
  end

  # 有擊球的局數
  def completed_roll_frames
    @frames.each_with_object([]) do |frame, result|
      result << frame if frame.has_rolls?
    end
  end

  def extra_pins(frame)
    return 0 if frame.last? # 第10局不額外加分

    frame_index = frame.num - 1

    if frame.strike?
      next_frames = completed_roll_frames[frame_index+1..frame_index+2]
      next_rolls = next_frames.map { |frame| frame.rolls }.flatten.reject { |roll| !roll }# 下兩局的擊球分數
      next_rolls[0].to_i + next_rolls[1].to_i # 下兩次擊球的分數總和
    elsif frame.space?
      completed_roll_frames[frame_index+1].rolls.first # 下一次擊球分數
    else
      0
    end
  end

  def header
    @frames.each_with_object('') do |frame, result|
      format_num = if frame.last?
                     "%3s" % frame.num
                   else
                     "%2s" % frame.num
                   end
      result << format_num + "  "
    end
  end
end
