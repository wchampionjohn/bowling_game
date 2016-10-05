class Game
  def initialize
    @rolls = [[nil, nil]] * 10
  end
  def roll points
    @rolls.each_with_index do |frame, frame_index|
      if frame.include? nil
        current_frame_index = frame_index

        frame.each_with_index do |times, times_index|
          if times.nil?
            current_times_index = times_index  if times.nil?
            @rolls[current_frame_index][current_times_index] = points
            break
          end
        end
        break
      end
    end
  end

  def scope
    @rolls.inject(0) do |sum, frame|
      sum += frame.reduce(:+)
    end
  end
end
