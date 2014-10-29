class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  
  validates_presence_of :position
  
  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  validates_numericality_of :position, {only_integer: true}

  # use delegate :title, to: :video, prefix: :video
  # def video_title  
  #   video.title
  # end

  def rating  
    review.rating if review
  end

  # called virtual attribute
  def rating=(new_rating)
    if review
      #review.update_attributes(rating: new_rating)
      # use update_column so that bypass the review model validation.
      review.update_column(:rating, new_rating)
    else
      review = Review.new(user: user, video: video, rating: new_rating)
      review .save(validate: false)
    end
  end

  def category_name
    category.name
  end
  
  # use delegate :category, to: :video
  # def category
  #   video.category
  # end

  private

  def review
    review ||= Review.where(user_id: user.id, video_id: video.id).first
  end

end