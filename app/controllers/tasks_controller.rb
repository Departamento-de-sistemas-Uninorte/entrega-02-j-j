class TasksController < ApplicationController
  before_action :authenticate_user!
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
    @task=Task.find(params[:id])    
    @task.destroy
    redirect_to tasks_path, notice: "Tweet eliminado"
    
  end

  def show
    @task=Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:tittle, :description, :user_id)
  end



end
