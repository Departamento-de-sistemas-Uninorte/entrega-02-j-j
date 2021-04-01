module Api
    module V1
        class RegistrationsController < Devise::RegistrationsController
            skip_before_action :verify_authenticity_token
            respond_to :json

            def create
                build_resource(sign_up_params)
                if resource.save
                    render json: "Cuenta para "+resource.email+" creada. Por favor, confirme su cuenta.", status: :created
                else
                    render json: {error: "No se pudo crear la cuenta"}, status: :unprocessable_entity
                end
            end

            def sign_up_params
                params.permit( :email, :password)
            end

            # private
        
            # def respond_with(resource, _opts = {})
            #     render json: resource
            # end
        
            
        end
    end
end
