require 'rails_helper'

RSpec.describe "Project", type: :system do
  include_examples 'sign in'

  scenario 'user post projects' do
    visit dashboard_path
    click_link 'new project'
  end
end
