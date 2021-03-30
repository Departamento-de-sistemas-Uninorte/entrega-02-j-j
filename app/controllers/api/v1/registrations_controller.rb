module Api
    module V1
        class RegistrationsController < Devise::RegistrationsController
            skip_before_action :verify_authenticity_token
            respond_to :json

            def create
                build_resource(sign_up_params)
                if resource.save
                    resource.confirm
                    render json: resource, status: :created
                else
                    render error: {error: "No se pudo crear eso"}
                end
            end

            def sign_up_params
                params.permit( :email, :password)
            end

            # private
        
            # def respond_with(resource, _opts = {})
            #     render json: resource
            # end
        
            # def respond_to_on_destroy
            #     head :no_content
            # end
        end
    end
end
