class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user
  
  validates_presence_of :position
  
  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  # use delegate :title, to: :video, prefix: :video
  # def video_title  
  #   video.title
  # end

  def rating  
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end

  def category_name
    category.name
  end
  
  # use delegate :category, to: :video
  # def category
  #   video.category
  # end

end