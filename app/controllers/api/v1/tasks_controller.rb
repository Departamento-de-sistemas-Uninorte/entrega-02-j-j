module Api
    module V1
        class TasksController < ApiController
            # before_action :authenticate_user!
            before_action :set_task, only: [:show, :destroy]

            #GET api/v1/tasks
            def index
              @tasks= Task.all
              #@tasks = Task.where[user_id: current_user.id]
              render json: @tasks
            end
            
            #POST api/v1/tasks
            def create
              @task=Task.new(task_params)
              @task.user_id = User.first.id
              # TODO: Implement auth
              if @task.save
                render json: @task, status: 200
              else
                render error: { error: "No se pudo hacer eso", status: 418}
              end    
            end

            #DEL api/v1/tasks
            def destroy       
              @task.destroy
              render json: { status: 200}
            end

            #GET api/v1/tasks/:id
            def show
              render json: @task
            end

            def task_params
              params.permit( :description)#, :user_id)
            end

            private

            def set_task
              @task=Task.find(params[:id])
            end

        end
    end
end
