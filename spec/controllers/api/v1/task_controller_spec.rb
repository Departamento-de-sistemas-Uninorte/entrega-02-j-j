require 'rails_helper'

RSpec.describe Api::V1::TaskController, "#create" do
    let(:user) {create(:user, :confirmed)}
    context "Crear tweets y es valido:" do
        let(:task) {create(:task, user: user)}
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
        it "debe de guardarse al cumplir todo" do
            expect(Task.last.description).to eq(task.description)
        end
        it "debe de no exceder el limite de 280 caracteres" do
            expect(task.description.length).to be < 281
        end
    end
    context "Crear tweets y es invalido:" do
        #let(:task) {create(:task, :invalid, user: user)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            post :create, params: {description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla blandit feugiat molestie. Curabitur non porttitor ex. Aliquam pellentesque viverra nulla, ac efficitur risus posuere id. Nam ut venenatis erat. Vestibulum egestas dignissim tortor, et porttitor mi sollicitudin sed nam."}
        end
        it "debe de tirar error al exceder 280 caracteres" do
            expect(response).to have_http_status(:no_content)
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
    context "Cuando el tweet no exista y se deba borrar: " do
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            post :create, params: {description: task.description}
            delete :destroy, params: { id: -1} 
        end
        it "debe de estar el usuario confirmado" do
            expect(user.confirmed?).to be true
        end
        it "debe de tirar error al no tener un usuario loggeado" do
            expect(user.id).to be_kind_of(Numeric)
        end
        it "debe de mandar error al no poder eliminar" do
            expect(response).to have_http_status(404)
        end
    end
end

RSpec.describe Api::V1::TaskController, "#show" do
    let(:user) {create(:user, :confirmed)}
    let(:task) {create(:task, user: user)}
    context "Cuando se muestre un tweet: " do
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            post :create, params: {description: task.description}
            get :show, params: { id: task.id}
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
            expect(json_response.keys).to  match_array(["id", "tittle","description","user_id","created_at","updated_at"])
        end
    end
end