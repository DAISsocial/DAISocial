class CompositeReview
  def initialize
    @reviews = []
  end

  def <<(review)
    @reviews << review
  end

  def mark
    @size = @reviews.size
    @mark = (@reviews.inject(0){ |sum, review| sum += review.rating })/@size
  end
end

class Review < CompositeReview
end

class RegularClientReview
  attr_reader :rating

  def initialize
    @rating = 10
  end
end

class ClientReview
  attr_reader :rating

  def initialize
    @rating = 5
  end
end