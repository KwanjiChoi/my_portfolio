shared_examples 'sign in' do
  include Devise::Test::IntegrationHelpers

  let!(:user) { create(:user, :sample_user) }

  before do
    sign_in user
  end
end
