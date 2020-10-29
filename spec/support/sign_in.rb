shared_examples 'sign in' do
  include Devise::Test::IntegrationHelpers

  let!(:user) { create(:user, :system_user) }

  before do
    sign_in user
  end
end

shared_examples 'sign in with teacher account' do
  include Devise::Test::IntegrationHelpers

  let!(:user) { create(:user, :teacher_account) }

  before do
    sign_in user
  end
end

