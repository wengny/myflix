require 'spec_helper'

describe Video do 

  it {should belong_to(:category)}
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}
  it {should have_many(:reviews).order("created_at DESC")}
  
  describe "search_by_title" do
    it "returns an empty array if there is no match" do
      mimi = Video.create(title: "cat mimi", description: "A cute cat")
      lili = Video.create(title: "cat lili", description: "A nauty cat")
      expect(Video.search_by_title("dog")).to eq([])
    end

    it "returns an array of one video for an exact match" do
      mimi = Video.create(title: "cat mimi", description: "A cute cat")
      lili = Video.create(title: "cat lili", description: "A nauty cat")
      expect(Video.search_by_title("cat mimi")).to eq([mimi])
    end

    it "returns an array of one video for a partial match" do
      mimi = Video.create(title: "cat mimi", description: "A cute cat")
      lili = Video.create(title: "cat lili", description: "A nauty cat")
      expect(Video.search_by_title("mimi")).to eq([mimi])
    end

    it "returns an array of all matches ordered by created_at" do
      mimi = Video.create(title: "cat mimi", description: "A cute cat")
      lili = Video.create(title: "cat lili", description: "A nauty cat")
      expect(Video.search_by_title("cat")).to eq([lili,mimi])
    end

    it "returns an empty array for a search with an empty string" do
      mimi = Video.create(title: "cat mimi", description: "A cute cat")
      lili = Video.create(title: "cat lili", description: "A nauty cat")
      expect(Video.search_by_title("")).to eq([])
    end
  end

  ## This block which test rails save function is not necessary.
  # it "save itself" do
  #   video = Video.new(title: "test", description: "a test video")
  #   video.save
  #   expect(Video.first).to eq(video)
  # end

  ## The following blocks can be replaced by shoulda-matchers:
  # it "belongs to a category" do
  #   drama = Category.create(name: "drama")
  #   monk = Video.create(title: "monk", description: "a great video.", category: drama)
  #   expect(monk.category).to eq(drama)
  # end

  # it "should not save a video without title" do
  #   video = Video.create(description: "a test video")
  #   expect(Video.count).to eq(0)
  # end

  # it "should not save a video without description" do
  #   video = Video.create(title: "test")
  #   expect(Video.count).to eq(0)
  # end
  
end