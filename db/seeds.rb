# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#User

user = User.new(
  username:     'kwanjiman',
  email:        'kwanji@example.com',
  password:     'password',
  confirmed_at: Time.now
)

user.save!

20.times do
  user = User.new(
    username:     Faker::Name.name,
    email:        Faker::Internet.email,
    password:     Faker::Internet.password,
    confirmed_at: Time.now
  )

  user.save!
end

#ProjectCategory

6.times do |n|
  ProjectCategory.create!(
    name: "category-#{n + 1}",
  )
end

#Project

users = User.take(10)
users.each do |user|
  user.update_attribute(:teacher, true)
  3.times do |n|
    project_category = ProjectCategory.all.sample
    project = user.projects.new(
      title:               Faker::Games::Pokemon.name,
      project_category:    project_category,
      main_image:          open("./db/fixtures/sample#{n + 1}.jpg"),
      content:             Faker::Lorem.paragraph(sentence_count: 30),
    )
    project.save!
  end
end
