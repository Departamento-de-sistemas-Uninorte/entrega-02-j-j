module Api
    module V1
        class SessionsController < Devise::SessionsController
            skip_before_action :verify_authenticity_token
            respond_to :json

            def create
                user = User.find_by_email(user_params[:email])
            
                if user && user.valid_password?(user_params[:password])
                  token = user.generate_jwt
                  render json: token.to_json
                else
                  render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
                end
            end
            
            def user_params
                params.permit(
                    :email, :password
                )
            end

            
            private
        
            # def user_params
            #     params.permit(
            #         :email, :password
            #     )
            # end
        
            def respond_with(resource, _opts = {})
            
                user = User.find_by_email(params[:email])
                # rescue ActiveRecord::RecordNotFound
                #   render json: { errors: 'User not found' }, status: :not_found
                
                # unless resource.id.nil?
                render json: {User: user}
                # else
                #     render json: {error: 'Sapo hp', resource: resource, user: user_params}, status: 418
                # end
            end

            def show
                render json: {email: user_params.email}
            end
        
            def respond_to_on_destroy
                head :no_content
            end
        end
    end
end