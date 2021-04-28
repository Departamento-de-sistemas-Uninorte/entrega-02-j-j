require 'rails_helper'

RSpec.describe Api::V1::TaskController, "#create" do
    let(:user) {create(:user, :confirmed)}
    let(:task) {create(:task, user: user)}
    context "Crear tweets:" do
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            post :create, params: {description: task.description}
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
        it "should return Tweet in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["info", "tweet"])
        end
        it "debe de no exceder el limite de 280 caracteres" do
            expect(task.description.length).to be < 281
        end
    end
end

RSpec.describe Api::V1::TaskController, "#index" do
    let(:user) {create(:user, :confirmed)}
    let(:task) {create(:task, user: user)}
    context "Cuando se deba listar todos los tweets: " do
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            post :create, params: {description: task.description}
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
        it "should return Tweet in JSON body" do
            json_response = JSON.parse(response.body)
            expect(json_response.first.keys).to  match_array(["id", "tittle","description","user_id","created_at","updated_at"])
        end
    end
end

RSpec.describe Api::V1::TaskController, "#delete" do
    let(:user) {create(:user, :confirmed)}
    let(:task) {create(:task, user: user)}
    context "Cuando el tweet exista y se deba borrar: " do
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            post :create, params: {description: task.description}
            delete :destroy, params: { id: task.id} 
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
        it "should return Tweet in JSON body" do
            json_response = response.body
            expect(json_response).to  match("Tweet borrado")
        end
    end
end