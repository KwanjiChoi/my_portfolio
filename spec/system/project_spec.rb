require 'rails_helper'

RSpec.describe "Project", type: :system, js: true do
  let!(:category2) { create(:project_category, name: 'category2') }
  let!(:category1) { create(:project_category, name: 'category1') }

  include_examples 'sign in'

  scenario 'user post projects' do
    visit dashboard_path
    click_link  'new project'
    fill_in     'Title',     with: 'sample title'
    select      'category1', from: 'カテゴリー'
    attach_file "project[main_image]", "#{Rails.root}/spec/fixtures/test.jpg"
    fill_in_rich_text_area 'project_content', with: 'sample content'
    click_on 'create project'
  end
end
