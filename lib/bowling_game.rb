class Game
  def initialize
    @rolls = []
  end
  def roll points
    @rolls << points
  end

  def scope
    @rolls.reduce(:+)
  end
end
