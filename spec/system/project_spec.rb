require 'rails_helper'

RSpec.describe "Project", type: :system, js: true do
  describe 'sign in user' do
    let!(:prefecture) { create(:prefecture, name: '兵庫県') }
    let!(:city)       { create(:city, prefecture: prefecture, name: '西宮市') }
    let!(:category2)  { create(:project_category, name: 'category2') }
    let!(:category1)  { create(:project_category, name: 'category1') }
    let!(:project_1)  { create(:project, title: 'project_1', user: user) }
    let!(:project_2)  { create(:project, title: 'project_2', user: user) }

    include_examples 'sign in with teacher account'

    scenario 'post projects' do
      visit projects_path
      click_link  'new project'
      fill_in     'Title',     with: 'sample title'
      select      'category1', from: 'カテゴリー'
      select      '兵庫県',     from: '都道府県'
      select      '西宮市',     from: '市区町村'
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

  describe 'not sign in user' do
    file = File.open 'spec/fixtures/sample_content.txt'
    content = file.read

    let!(:user)    { create(:user, email: 'sample_user@example.com', password: 'password') }
    let!(:project) { create(:project, title: 'project_title', content: content) }

    def sign_in_user(email: nil, password: nil)
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Log in'
    end

    scenario 'get product detail path' do
      visit root_path
      expect(page).to have_css ".recent-project-#{project.id}"
      expect(page).to have_content project.title
      within ".recent-project-#{project.id}" do
        click_link '続きを読む'
      end
      expect(page).to have_content project.title
      expect(page).to have_content 'ここにある長いのは物干し。'
      expect(page).to have_no_css '.modal'
      click_button 'reservation now!!'

      within '.modal' do
        click_link 'ログインして予約する'
      end

      sign_in_user(email: 'sample_user@example.com', password: 'password')

      visit detail_project_path(project)
      # expect(current_path).to eq detail_project_path(project)

      click_button 'reservation now!!'
      within '.modal' do
        expect(page).to have_button 'このまま予約する'
        expect(page).to have_button 'このプロジェクトは電話予約できません'
      end
    end
  end
end
