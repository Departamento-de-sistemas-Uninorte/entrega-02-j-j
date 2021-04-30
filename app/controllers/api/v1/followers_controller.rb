module Api
    module V1
        class FollowersController < ApiController
            before_action :authenticate_user!
            #before_action :find_user, only: [:show]

            def index
                followers = Follow.where(follow_id: @current_user_id)
                followersaux = []
                followers.each do |n|
                    followersaux.push({seguidor_id: n.user_id, email: User.find(n.user_id).email})
                end
                render json: {followers: followersaux}
            end

        end
    end
end