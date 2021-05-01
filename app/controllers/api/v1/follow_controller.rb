module Api
    module V1
        class FollowController < ApiController
            before_action :authenticate_user!
            before_action :find_user, only: [:create]

            def index
                following = Follow.where(user_id: @current_user_id)
                followingaux = []
                following.each do |n|
                    followingaux.push({seguido_id: n.follow_id, email: User.find(n.follow_id).email})
                end
                render json: {following: followingaux}
            end
            
            def create
                if @current_user_id != @user_to_follow.id
                    follow = Follow.new({user_id: @current_user_id, follow_id: @user_to_follow.id})
                    begin
                        if follow.save
                            
                            UserMailer.notif(current_user, @user_to_follow).deliver_now
                            render json: {info: "Usuario Seguido", user: @user_to_follow.email}, status: 201
                        end
                    rescue ActiveRecord::RecordNotUnique
                        render json: {error: "Usuario ya seguido"}, status: :unprocessable_entity
                    end
                else
                    render json: { error: "No te puedes seguir a ti mismo"}, status: :unprocessable_entity
                end
                
            end

            private

            def find_user
                begin
                  @user_to_follow=User.find(params[:id])
                rescue ActiveRecord::RecordNotFound
                  render json: {error: "Usuario no encontrado"}, status: 404
                end
            end

        end
    end
end
