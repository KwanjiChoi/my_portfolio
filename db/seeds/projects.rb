puts 'Creating projects'

users = User.take(10)
users.each do |user|
  user.update_attribute(:teacher, true)
  user.create_performance
  user.update_attribute(:phone_number, "0900000#{rand(10000).to_s}") if user.id.even?
  3.times do |n|
    project_category = ProjectCategory.all.sample
    project = user.projects.new(
      title:               Faker::Games::Pokemon.name,
      project_category:    project_category,
      main_image:          open("./db/fixtures/sample#{n + 1}.jpg"),
      content:             Faker::Lorem.paragraph(sentence_count: 30),
    )
    project.save!
    project.create_performance
    project.update_attribute(:phone_reservation, true) unless project.user.phone_number.nil?
  end
end
