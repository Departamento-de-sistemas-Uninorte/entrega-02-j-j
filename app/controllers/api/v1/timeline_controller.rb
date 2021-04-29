module Api
    module V1
        class TimelineController < ApiController
            before_action :authenticate_user!
            #before_action :set_task, only: [:show, :destroy]

            def index
                timeline = Task.where(user_id: User.find(@current_user_id).follows).or(Task.where(user_id: @current_user_id))
                render json: {timeline: timeline}
            end

        end
    end
end
