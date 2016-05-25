class Word
  attr_accessor :word
  attr_reader :cost, :key

  def initialize(word)
    @cost = cost_increment
    @keys = keyword
    @word = word
  end

  def cost_increment
    0
  end

  def keyword
    []
  end

  def info
    "This word decrement on #{cost}"
  end
end

class NegativeWord < Word
  def cost_increment
    10
  end

  def keyword
    [:positive]
  end
end

class PositiveWord < Word
  def cost_increment
    -10
  end

  def keyword
    [:negative]
  end
end