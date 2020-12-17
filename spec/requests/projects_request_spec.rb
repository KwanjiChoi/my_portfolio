require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let!(:user)          { create(:user, teacher: true) }
  let!(:project)       { create(:project, user: user) }
  let!(:other_user)    { create(:user) }
  let!(:other_project) { create(:project, user: other_user) }

  describe "GET #index" do
    it "returns http success with sign in user" do
      sign_in user
      get projects_path
      expect(response).to have_http_status(:success)
    end

    it "returns http status 302 with not sign in user" do
      get projects_path
      expect(response.code).to eq('302')
    end
  end

  describe "GET #new" do
    it "returns http success with sign in user" do
      sign_in user
      get new_project_path
      expect(response).to have_http_status(:success)
    end

    it "returns http status code 302 when user doesn't sign in" do
      get new_project_path
      expect(response.code).to eq('302')
    end

    it "returns http status code 302 when user does not activate teacher account" do
      user.teacher = false
      sign_in user
      get new_project_path
      expect(response.code).to eq '302'
    end
  end

  describe "GET #show" do
    it "returns http status 302 with not sign in user" do
      get project_path(project)
      expect(response.code).to eq '302'
    end

    it 'returns http success with sign in user' do
      sign_in user
      get project_path(project)
      expect(response).to have_http_status(:success)
    end

    it 'returns status code 302 when getting other user`s project show page' do
      sign_in user
      get project_path(other_project)
      expect(response.code).to eq '302'
    end
  end

  describe "GET #edit" do
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

  describe 'POST #create' do
    let!(:category) { create(:project_category) }
    let(:project_params) do
      attributes_for(:project, title: 'Sample Title',
                               location_attributes: attributes_for(:project_location),
                               main_image: Rack::Test::UploadedFile.new(
                                 File.join(Rails.root, 'spec/fixtures/test.jpg')
                               ),
                               content: 'a' * 101,
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

    it "does not add a project when user does not activate teacher account" do
      user.teacher = false
      sign_in user
      expect do
        post projects_path, params: { project: project_params }
      end.not_to change(Project, :count)
    end
  end

  describe 'PUT #update' do
    let!(:category) { create(:project_category) }
    let(:project_params) do
      attributes_for(:project, title: 'edit project',
                               location_attributes: attributes_for(:project_location),
                               main_image: Rack::Test::UploadedFile.new(
                                 File.join(Rails.root, 'spec/fixtures/test.jpg')
                               ),
                               content: 'a' * 101,
                               user: user,
                               project_category_id: category.id)
    end
    it 'edit project' do
      sign_in user
      put project_path(project), params: { project: project_params }
      expect(project.reload.title).to eq 'edit project'
    end

    it 'does not edit project when user not sign in' do
      put project_path(project), params: { project: project_params }
      expect(project.reload.title).not_to eq 'edit project'
    end
  
    it 'does not edit project when other user' do
      sign_in other_user
      put project_path(project), params: { project: project_params }
      expect(project.reload.title).not_to eq 'edit project'
    end
  end

  describe "DELETE #destroy" do
    it "is deleted with sign in user" do
      sign_in user
      expect  do
        delete project_path(project)
      end.to change(Project, :count)
    end

    it "does not delete project with not sign in user" do
      expect do
        delete project_path(project)
      end.not_to change(Project, :count)
    end

    it "does not delete project when deleting other users project" do
      sign_in user
      expect  do
        delete project_path(other_project)
      end.not_to change(Project, :count)
    end
  end

  describe 'GET #feed' do
    it 'whoever can get Project#feed' do
      get feed_projects_path(category_id: project.project_category_id)
      expect(response).to have_http_status(:success)

      sign_in user
      get feed_projects_path(category_id: project.project_category_id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #detail' do
    it 'whoever can get Project#detail' do
      get detail_project_path(project)
      expect(response).to have_http_status(:success)

      sign_in user
      get detail_project_path(project)
      expect(response).to have_http_status(:success)

      get detail_project_path(other_project)
      expect(response).to have_http_status(:success)
    end
  end
end
