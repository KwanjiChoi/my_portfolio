puts 'Creating users'

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