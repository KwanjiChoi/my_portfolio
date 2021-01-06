FactoryBot.define do
  factory :project do
    title         { "MyString" }
    main_image    { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    content       { "a" * 101 }
    association   :user
    association   :project_category

    after(:create) do |project|
      create(:project_performance, performancable: project)
    end
  end
end
