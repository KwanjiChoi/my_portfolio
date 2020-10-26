require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let!(:user)         { create(:user) }
  let!(:project)      { create(:project, user: user) }
  let!(:other_user)   { create(:user) }
  let(:other_project) { create(:project) }

  describe "GET /index" do
    it "returns http success with sign in user" do
      sign_in user
      get projects_path
      expect(response).to have_http_status(:success)
    end

    it "returns http success with not sign in user" do
      get projects_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success with sign in user" do
      sign_in user
      get new_project_path
      expect(response).to have_http_status(:success)
    end

    it "returns http status code 302 when user doesn't sign in" do
      get new_project_path
      expect(response.code).to eq('302')
    end
  end

  describe "GET /show" do
    it "returns http success with not sign in user" do
      get project_path(project)
      expect(response).to have_http_status(:success)
    end

    it 'returns http success with sign in user' do
      sign_in user
      get project_path(project)
      expect(response).to have_http_status(:success)
    end

    it 'returns http success when getting project show page related other user' do
      sign_in user
      get project_path(other_project)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      sign_in user
      get edit_project_path(project)
      expect(response).to have_http_status(:success)
    end

    it "returns http status code 302 when user doesn't sign in" do
      get edit_project_path(project)
      expect(response.code).to eq('302')
    end

    it "returns http status 302 when user get other users project edit page" do
      sign_in user
      get edit_project_path(other_project)
      expect(response.code).to eq('302')
    end
  end

  describe 'POST /create' do
    let!(:category)     { create(:project_category) }
    let(:project_params) do
      attributes_for(:project, title: 'Sample Title',
                               main_image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')),
                               content: 'Sample Content',
                               user: user,
                               project_category_id: category.id)
    end
    it 'adds a project' do
      sign_in user
      expect do
        post projects_path, params: { project: project_params }
      end.to change(Project, :count).by(1)
    end

    it 'does not add a project when user not logged in' do
      expect do
        post projects_path, params: { project: project_params }
      end.to change(Project, :count).by(0)
    end
  end

  describe 'PUT /update' do
  end

  describe "DELETE /destroy" do
    it "returns http success with sign in user" do
      sign_in user
      delete project_path(project)
      expect(response).to have_http_status(:success)
    end

    it "returns http status code 302 with not sign in user" do
      delete project_path(project)
      expect(response.code).to eq('302')
    end

    it "returns http status code 302 when deleting other users project" do
      sign_in user
      delete project_path(other_project)
      expect(response.code).to eq('302')
    end
  end
end
