require 'spec_helper'

describe Category do

  it {should have_many(:videos)}

  describe "recent_videos" do
    it "returns the videos in the reverse chronical order by created at" do
      commedies =  Category.create(name: "TV Commedies")
      mimi = Video.create(title: "cat mimi", description: "A cute cat", category: commedies)
      lili = Video.create(title: "cat lili", description: "A nauty cat", category: commedies, created_at: 1.day.ago)
      expect(commedies.recent_videos).to eq([mimi, lili])
    end

    it "returns all the videos if there are less than 6 videos" do
      commedies =  Category.create(name: "TV Commedies")
      mimi = Video.create(title: "cat mimi", description: "A cute cat", category: commedies)
      lili = Video.create(title: "cat lili", description: "A nauty cat", category: commedies, created_at: 1.day.ago)
      expect(commedies.recent_videos.count).to eq(2)
    end 

    it "returns 6 videos if there are more than 6 videos" do
      commedies =  Category.create(name: "TV Commedies")
      7.times {Video.create(title: "cat mimi", description: "A cute cat", category: commedies)} 
      expect(commedies.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do
      commedies =  Category.create(name: "TV Commedies")
      6.times {Video.create(title: "cat mimi", description: "A cute cat", category: commedies)} 
      lili = Video.create(title: "cat lili", description: "A nauty cat", category: commedies, created_at: 1.day.ago)
      expect(commedies.recent_videos).not_to include(lili)
    end

    it "returns an empty array if the category does not have any video" do
      commedies =  Category.create(name: "TV Commedies")
      expect(commedies.recent_videos).to eq([])
    end
  end
  
  # it "save itself" do
  #   category = Category.new(name: "comedies")
  #   category.save
  #   expect(Category.first).to eq(category)
  # end

  # it "has many videos" do
  #   comedies = Category.create(name: "comedies")
  #   south_park = Video.create(title: "south_park", description: "great video!", category: comedies) 
  #   futurama = Video.create(title: "futurama", description: "nice video!", category: comedies)
  #   #expect(comedies.videos).to include(futurama, south_park)
  #   expect(comedies.videos).to eq([futurama, south_park])
  # end

end