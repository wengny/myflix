# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Video.destroy_all(:description => nil)
# video = Video.find_or_initialize_by(title: 'Monk')
# video.category_id = 1
# video.small_cover_url = "/tmp/monk.jpg"
# video.large_cover_url = "/tmp/monk_large.jpg"
# video.description = "Monk's description..."
# video.save!

commedies = Category.create(name: "Comedies")
dramas = Category.create(name: "Dramas")

Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: "/tmp/futurama.jpg", category: commedies )
Video.create(title: "Family Guy", description: "Family guy story", small_cover_url: "/tmp/family_guy.jpg", category: commedies )
Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: "/tmp/futurama.jpg", category: commedies )
Video.create(title: "Family Guy", description: "Family guy story", small_cover_url: "/tmp/family_guy.jpg", category: commedies )
Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: "/tmp/futurama.jpg", category: commedies )
Video.create(title: "Family Guy", description: "Family guy story", small_cover_url: "/tmp/family_guy.jpg", category: commedies )
Video.create(title: "Futurama", description: "Pizza boy Philip J. Fry awakens in the 31st century after 1,000 years of cryogenic preservation in this animated series. After he gets a job at an interplanetary delivery service, Fry embarks on ridiculous escapades to make sense of his predicament.", small_cover_url: "/tmp/futurama.jpg", category: commedies )
Video.create(title: "Family Guy", description: "Family guy story", small_cover_url: "/tmp/family_guy.jpg", category: commedies )

Video.create(title: "Monk", description: "Paranoid SF detective.", small_cover_url: "/tmp/monk.jpg",large_cover_url: "/tmp/monk_large.jpg", category: dramas )
Video.create(title: "Monk", description: "Paranoid SF detective.", small_cover_url: "/tmp/monk.jpg",large_cover_url: "/tmp/monk_large.jpg", category: dramas )
Video.create(title: "Monk", description: "Paranoid SF detective.", small_cover_url: "/tmp/monk.jpg",large_cover_url: "/tmp/monk_large.jpg", category: dramas )

User.create(email: "hweng@ucsd.edu", full_name: "Huawei Weng", password: "password")
