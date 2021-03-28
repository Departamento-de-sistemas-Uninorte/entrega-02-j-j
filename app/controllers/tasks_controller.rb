class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :destroy]
  def index
    @tasks= Task.all
  end

  def new
    @tasks= Task.new
  end

  def create
    @task=Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Tweet publicado"
    else
      render :new
    end    
  end

  def destroy    
    @task.destroy
    redirect_to tasks_path, notice: "Tweet eliminado"
    
  end

  def show
  end

  def task_params
    params.require(:task).permit(:tittle, :description, :user_id)
  end

  private

  def set_task
    @task=Task.find(params[:id])
  end



end
