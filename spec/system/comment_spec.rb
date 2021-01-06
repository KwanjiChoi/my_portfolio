RSpec.describe "Comment", type: :system do
  let!(:user)    { create(:user) }
  let!(:project) { create(:project) }

  scenario 'comment form could be shown only sign in user' do
    visit detail_project_path(project)
    expect(page).to have_no_css '.comment-form'

    sign_in user
    visit detail_project_path(project)
    expect(page).to have_css '.comment-form'
  end
end
