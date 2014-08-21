class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
    @task = Task.new
  end

  def show
  end

  def new
    @task = Task.new
    #@task.sub_tasks.build
  end

  def edit
    #@task.sub_tasks.build
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
        format.js {}
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
      format.js {}
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      #params.require(:task).permit(:id, :description, :finished, sub_tasks_attributes: [:sub_task, :id, :description] )
      params.require(:task).permit(:id, :description, :finished)
    end
end
