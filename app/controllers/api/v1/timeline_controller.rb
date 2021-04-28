module Api
    module V1
        class TimelineController < ApiController
            before_action :authenticate_user!
            #before_action :set_task, only: [:show, :destroy]

            def index
                timeline = Task.where(user_id: User.find(@current_user_id).follows).or(Task.where(user_id: @current_user_id))
                render json: {timeline: timeline}
            end

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
