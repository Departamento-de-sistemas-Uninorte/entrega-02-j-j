module Api
    module V1
        class FollowersController < ApiController
            before_action :authenticate_user!
            #before_action :find_user, only: [:show]

            def index
                followers = Follow.where(follow_id: @current_user_id)
                render json: {followers: followers}
            end

        end
    end
end