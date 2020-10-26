FactoryBot.define do
  factory :project do
    title { "MyString" }
    main_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    content { "MyContent" }
    association :user
    association :project_category
  end
end
