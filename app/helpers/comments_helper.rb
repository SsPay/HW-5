module CommentsHelper
  def count_rating(sample)
    sample.where(count: 1).count - sample.where(count: -1).count
  end
end
