module Api
    module V1
        class SessionsController < Devise::SessionsController
            skip_before_action :verify_authenticity_token
            respond_to :json

            def create
                user = User.find_by_email(user_params[:email])
            
                if user && user.valid_password?(user_params[:password])
                  user.update_column(:jti, User.generate_jti)
                  token = user.generate_jwt(user.jti)
                  render json: {'Token de acceso': token}
                else
                  render json: { error: 'Correo o contraseña invalidos' }, status: :unprocessable_entity
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

                if request.headers['Authorization'].present?
                        begin
                            jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[0], Rails.application.secret_key_base).first
                            @current_user_id = jwt_payload['id']
                            User.revoke_jwt(jwt_payload, User.find(@current_user_id))
                            render json: "Token eliminado correctamente"
                        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError => error
                            render json: {error: "Token erronea"}, status: 401
                        end
                else
                    render json: "La petición no contiene el header de 'Authorization'", status: 401
                end
            end
        end
    end
end