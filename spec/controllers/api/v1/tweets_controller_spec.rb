require 'rails_helper'

RSpec.describe Api::V1::TweetController, "#create" do
    let(:user) {create(:user, :confirmed)}
    let(:task) {create(:task, user: user)}
    context "Crear tweets:" do
        it "debe de tirar error al no tener un usuario loggeado" do
            expect(user.id).to be_kind_of(Numeric)
        end
    end
end

RSpec.describe Api::V1::TweetController, "#index" do
    let(:user) {create(:user, :confirmed)}
    let(:task) {create(:task, user: user)}
    context "When a tweet exist" do
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            get :show, params: { id: task.id} 
        end
        it "should return HTTP success code" do
            expect(response).to have_http_status(:success)
        end
        it "should return Tweet in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["id", "tittle","description","user_id","created_at","updated_at"])
        end
    end
end