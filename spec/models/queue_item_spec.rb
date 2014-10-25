require 'spec_helper'

describe QueueItem do 

  it {should belong_to(:video)}
  it {should belong_to(:user)}
  it {should validate_presence_of(:position)}
  it {should validate_numericality_of(:position).only_integer}

  describe "#video_title" do 
    it "returns the title of the associated video" do 
      video = Fabricate(:video, title: 'Monk')
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq('Monk')
    end
  end

  describe "#rating" do 
    it "returns the rating from the review when the review is present" do 
      video = Fabricate(:video, title: 'Monk')
      user = Fabricate(:user)
      review = Fabricate(:review, video: video, user: user, rating: 4)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(4)
    end

    it "returns nil when the review is not present" do
      video = Fabricate(:video, title: 'Monk')
      user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe "#category_name" do
    it "returns category name of the video" do
      cat = Fabricate(:category, name: 'comedy')
      video = Fabricate(:video, category: cat)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_name).to eq('comedy')
    end
  end

  describe "#category" do
    it "returns category of the video" do
      cat = Fabricate(:category, name: "comedies")
      #cat = Fabricate(:category)
      video = Fabricate(:video, category: cat)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(cat)
    end
  end
end