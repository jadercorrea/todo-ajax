require 'rails_helper'

RSpec.describe TasksController, :type => :controller do

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:task)
  }

  let(:invalid_attributes) {
    { description: nil }
  }

  let(:parent) {
    FactoryGirl.create(:task, description: 'parent', finished: false, parent_id: nil)
  }
  let(:children) {
    FactoryGirl.create(:task, description: 'children', finished: false, parent_id: parent.id)
  }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all parent tasks as @tasks" do
      tasks = Task.just_parents
      get :index, {}, valid_attributes
      expect(assigns(:tasks)).to eq(tasks)
    end

    it "assigns a new task as @task" do
      get :index, {}, valid_session
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe "GET show" do
    before do
      parent && children
    end

    it "assigns all children tasks as @tasks" do
      tasks = Task.find(parent.id).children
      get :show, {id: parent.id}, valid_session
      expect(assigns(:tasks)).to eq(tasks)
    end

    it "assigns a new task as @task with parent id" do
      get :show, {id: parent.id}, valid_session
      expect(assigns(:task)).to be_a_new(Task)
      expect(assigns(:task).parent_id).to eq(parent.id)
    end
  end

  describe "POST create" do
    it "creates a new Task" do
      expect {
        post :create, {:task => valid_attributes, format: :js}, valid_session
      }.to change(Task, :count).by(1)
    end

    it "assigns a newly created task as @task" do
      post :create, {:task => valid_attributes, format: :js}, valid_session
      expect(assigns(:task)).to be_a(Task)
      expect(assigns(:task)).to be_persisted
    end

    it "remains in the same page" do
      post :create, {:task => valid_attributes, format: :js}, valid_session
      expect(response).not_to be_redirect
    end
  end

  describe "PUT update" do
    let(:new_attributes) {
      FactoryGirl.attributes_for(:task, description: 'Updated task')
    }

    it "updates the requested task" do
      task = Task.create! valid_attributes
      put :update, {:id => task.to_param, :task => new_attributes, format: :js}, valid_session
      task.reload
    end

    it "assigns the requested task as @task" do
      task = Task.create! valid_attributes
      put :update, {:id => task.to_param, :task => valid_attributes, format: :js}, valid_session
      expect(assigns(:task)).to eq(task)
    end

    it "remains in the same page" do
      task = Task.create! valid_attributes
      put :update, {:id => task.to_param, :task => valid_attributes, format: :js}, valid_session
      expect(response).not_to be_redirect
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete :destroy, {:id => task.to_param, format: :js}, valid_session
      }.to change(Task, :count).by(-1)
    end

    it "remains in the same page" do
      task = Task.create! valid_attributes
      delete :destroy, {:id => task.to_param, format: :js}, valid_session
      expect(response).not_to be_redirect
    end
  end
end
