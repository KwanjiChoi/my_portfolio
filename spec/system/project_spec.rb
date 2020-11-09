require 'rails_helper'

RSpec.describe "Project", type: :system, js: true do
  let!(:category2) { create(:project_category, name: 'category2') }
  let!(:category1) { create(:project_category, name: 'category1') }
  let!(:project_1) { create(:project, title: 'project_1', user: user) }
  let!(:project_2) { create(:project, title: 'project_2', user: user) }

  include_examples 'sign in with teacher account'

  scenario 'user post projects' do
    visit dashboard_path
    click_link  'new project'
    fill_in     'Title',     with: 'sample title'
    select      'category1', from: 'カテゴリー'
    attach_file "project[main_image]", "#{Rails.root}/spec/fixtures/test.jpg"
    fill_in_rich_text_area 'project_content', with: 'a' * 101
    click_on 'create project'
    expect(page).to have_content 'created successfully'
  end

  scenario 'user has many project and visit projects_path' do

    visit projects_path
    within '.jumbotron' do
      expect(page).to have_selector '.product-box', count: 2
    end
    
  end
end
