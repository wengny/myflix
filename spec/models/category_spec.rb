require 'spec_helper'

describe Category do

  it {should have_many(:videos)}
  
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