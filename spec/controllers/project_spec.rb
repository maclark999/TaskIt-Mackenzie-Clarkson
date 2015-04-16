require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do

  before :each do
      @user = User.create!(first_name: 'person',
      last_name: 'persons',
      email: '123@butt.com',
      password: '123',
      admin: false)
      @project = Project.create!(name: 'dumb')
      session[:user_id] = @user.id
    end

  context "user is signed in" do
  describe "GET #index" do
    #context "user is signed in" do
      it "renders index" do
        get :index
        expect(response).to render_template(:index)
      end
  end

  describe "POST #create" do
    #context "user is signed in" do
      it "creates a new project and makes user owner on new project" do
        post :create, {project: {name: 'project'}}

        expect(Project.last.memberships.last.role).to eq("owner")
      end
    end
  end

  describe "GET #show" do
    context "user is not a member of the project" do
      before do
        @user1 = User.create!(first_name: 'human',
        last_name: 'humans',
        email: '456@butt.com',
        password: '123',
        admin: false)
        session[:user_id] = @user1.id
      end

        it "renders index page when user is not member of project" do
          get :show, id: @project.id
          expect(response).to redirect_to("/projects")
        end
    end
  end

  describe "DELETE #destroy" do
    context "user is not an owner/admin" do
      it "does not allow a regular member to delete a project" do
        @membership = Membership.create!(user_id: @user.id, role: "member", project_id: @project.id)
        delete :destroy, id: @project
        expect(response).to render_template(:show)
      end
    end
  end

end
