require 'rails_helper'

RSpec.describe Api::V1::TimelineController, "#index" do
    let(:user) {create(:user, :confirmed)}
    let(:userA) {create(:user, :confirmed)}
    let(:userB) {create(:user, :confirmed)}

    context "Al mostrar una timeline: " do
        before do
            Follow.new({user_id: user.id, follow_id: userA.id})
            Follow.new({user_id: userA.id, follow_id: user.id})
            Follow.new({user_id: userB.id, follow_id: userA.id})
            2.times do
                Task.new({description: "Prueba", user_id: user.id})
            end
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
            expect(json_response.keys).to  match_array(["timeline"])
        end


    end
end
