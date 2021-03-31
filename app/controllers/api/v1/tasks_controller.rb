module Api
    module V1
        class TasksController < ApiController
            before_action :authenticate_user!
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
              @task.user_id = @current_user_id
              # TODO: Implement auth
              if @task.save
                render json: {info: "Tweet creado", tweet: @task}, status: 201
              elsif @task.description.length > 280
                render json: { error: "Excede el limite de 280 caracteres"}, status: :unprocessable_entity
              else
                render json: { error: "No se pudo crear el tweet"}, status: :unprocessable_entity
              end    
            end

            #DEL api/v1/tasks
            def destroy       
              if @task.destroy
                render json: "Tweet borrado", status: 200
              else
                render json: {error: "No se pudo borrar el tweet"}, status: :unprocessable_entity
              end
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
              begin
                @task=Task.find(params[:id])
              rescue ActiveRecord::RecordNotFound
                render json: {error: "Tweet no encontrado"}, status: 404
              end
            end

        end
    end
end
