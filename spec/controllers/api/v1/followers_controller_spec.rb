require 'rails_helper'

RSpec.describe Api::V1::FollowersController, "#index" do
    let(:user) {create(:user, :confirmed)}
    #let(:userToFollow) {create(:user, :confirmed)}

    context "Al mostrar una timeline: " do
        
        before do            
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            get :index
        end
        it "debe de estar el usuario confirmado" do
            expect(user.confirmed?).to be true
        end
        it "debe de tirar error al no tener un usuario loggeado" do
            expect(user.id).to be_kind_of(Numeric)
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(:success)
        end
        it "should return timeline in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["followers"])
        end

    end
end

