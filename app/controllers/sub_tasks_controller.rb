class SubTasksController < ApplicationController
  before_action :set_sub_task, only: [:update, :destroy]
  before_action :set_task_id, only: [:create]

  def index
    sub_tasks_per_task
    @sub_task = SubTask.new
  end

  def create
    respond_to do |format|
      if @sub_task.save
        format.js {}
      end
    end
  end

  def update
    respond_to do |format|
      if @sub_task.update(sub_task_params)
        format.js {}
      end
    end
  end

  def destroy
    @sub_task.destroy
    respond_to do |format|
      format.js {}
    end
  end

  private

  def sub_tasks_per_task
    @sub_tasks = SubTask.by_task(params[:task_id])
  end

  def set_task_id
    @sub_task = SubTask.new(sub_task_params)
  end

  def set_sub_task
    @sub_task = SubTask.find(params[:id])
  end

  def sub_task_params
    params.require(:sub_task).permit(:id, :description, :finished, :task_id)
  end
end
