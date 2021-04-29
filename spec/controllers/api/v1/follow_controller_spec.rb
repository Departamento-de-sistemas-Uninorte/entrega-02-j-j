require 'rails_helper'

RSpec.describe Api::V1::FollowController, "#create" do
    let(:user) {create(:user, :confirmed)}
    

    context "Al seguir: " do
        let(:userToFollow) {create(:user, :confirmed)}
        before do            
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            post :create, params: {id: userToFollow.id}
        end

        it "el usuario a seguir debe de existir" do
            expect(userToFollow).not_to be_falsy
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
            expect(json_response.keys).to  match_array(["info", "user"])
        end


    end
    context "Al no poder seguir porque ya lo sigue: " do
        let(:userToFollow) {create(:user, :confirmed)}
        before do            
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            post :create, params: {id: userToFollow.id}
            post :create, params: {id: userToFollow.id}
        end

        it "el usuario a seguir debe de existir" do
            expect(userToFollow).not_to be_falsy
        end
        it "debe de estar el usuario confirmado" do
            expect(user.confirmed?).to be true
        end
        it "debe de tirar error al no tener un usuario loggeado" do
            expect(user.id).to be_kind_of(Numeric)
        end
        it "should return HTTP error code" do
            expect(response).to have_http_status(:unprocessable_entity)
        end
        it "should return timeline in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["error"])
        end
    end
    context "Al no poder seguir porque es el mismo usuario: " do
        let(:userToFollow) {create(:user, :confirmed)}
        before do            
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            post :create, params: {id: user.id}
        end

        it "el usuario a seguir debe de existir" do
            expect(userToFollow).not_to be_falsy
        end
        it "debe de estar el usuario confirmado" do
            expect(user.confirmed?).to be true
        end
        it "debe de tirar error al no tener un usuario loggeado" do
            expect(user.id).to be_kind_of(Numeric)
        end
        it "should return HTTP error code" do
            expect(response).to have_http_status(:unprocessable_entity)
        end
        it "should return timeline in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["error"])
        end
    end
    context "Al no poder seguir porque no se encuetra el usuario: " do
        before do            
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            post :create, params: {id: -1}
        end
        it "debe de estar el usuario confirmado" do
            expect(user.confirmed?).to be true
        end
        it "debe de tirar error al no tener un usuario loggeado" do
            expect(user.id).to be_kind_of(Numeric)
        end
        it "should return HTTP error code" do
            expect(response).to have_http_status(404)
        end
        it "should return timeline in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["error"])
        end
    end

end

RSpec.describe Api::V1::FollowController, "#index" do
    let(:user) {create(:user, :confirmed)}
    let(:userToFollow) {create(:user, :confirmed)}

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
            expect(json_response.keys).to  match_array(["following"])
        end
    end
end

