class TasksController < ApplicationController
  before_action :set_task, only: [:update, :destroy]

  def index
    @tasks = Task.just_parents
    @task = Task.new
    render :show
  end

  def show
    @tasks = set_task.children
    @task = Task.new(parent_id: params[:id])
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.js {}
      else
        format.js {}
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.js {}
      else
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.js {}
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:id, :description, :finished, :parent_id)
  end
end
