require 'rails_helper'

RSpec.describe Api::V1::TweetController, "#create" do
    let(:user) {create(:user, :confirmed)}
    context "Crear tweets y es valido:" do
        let(:tweet) {create(:tweet, user: user)}
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            post :create, params: {description: tweet.description}
        end
        it "debe de estar el usuario confirmado" do
            expect(user.confirmed?).to be true
        end
        it "debe de tirar error al no tener un usuario loggeado" do
            expect(user.id).to be_kind_of(Numeric)
        end
        it "debe de retornar HTTP exitoso" do
            expect(response).to have_http_status(:success)
        end
        it "debe de retornar el tweet en el JSON" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["info", "tweet"])
        end
        it "debe de guardarse al cumplir todo" do
            expect(Tweet.last.description).to eq(tweet.description)
        end
        it "debe de no exceder el limite de 280 caracteres" do
            expect(tweet.description.length).to be < 281
        end
    end
    context "Crear tweets y es invalido:" do
        #let(:tweet) {create(:tweet, :invalid, user: user)}
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

RSpec.describe Api::V1::TweetController, "#index" do
    let(:user) {create(:user, :confirmed)}
    let(:tweet) {create(:tweet, user: user)}
    context "Cuando se deba listar todos los tweets: " do
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            post :create, params: {description: tweet.description}
            get :index
        end
        it "debe de estar el usuario confirmado" do
            expect(user.confirmed?).to be true
        end
        it "debe de tirar error al no tener un usuario loggeado" do
            expect(user.id).to be_kind_of(Numeric)
        end
        it "debe de retornar HTTP exitoso" do
            expect(response).to have_http_status(:success)
        end
        it "debe de retornar el tweet en el JSON" do
            json_response = JSON.parse(response.body)
            expect(json_response.first.keys).to  match_array(["id", "tittle","description","user_id","created_at","updated_at"])
        end
    end
end

RSpec.describe Api::V1::TweetController, "#delete" do
    let(:user) {create(:user, :confirmed)}
    let(:tweet) {create(:tweet, user: user)}
    context "Cuando el tweet exista y se deba borrar: " do
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            post :create, params: {description: tweet.description}
            delete :destroy, params: { id: tweet.id} 
        end
        it "debe de estar el usuario confirmado" do
            expect(user.confirmed?).to be true
        end
        it "debe de tirar error al no tener un usuario loggeado" do
            expect(user.id).to be_kind_of(Numeric)
        end
        it "debe de retornar HTTP exitoso" do
            expect(response).to have_http_status(:success)
        end
        it "debe de retornar el tweet en el JSON" do
            json_response = response.body
            expect(json_response).to  match("Tweet borrado")
        end
    end
    context "Cuando el tweet no exista y se deba borrar: " do
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            post :create, params: {description: tweet.description}
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

RSpec.describe Api::V1::TweetController, "#show" do
    let(:user) {create(:user, :confirmed)}
    let(:tweet) {create(:tweet, user: user)}
    context "Cuando se muestre un tweet: " do
        before do
            token = user.generate_jwt(user.jti)
            request.headers["Authorization"] = "#{token}"
            post :create, params: {description: tweet.description}
            get :show, params: { id: tweet.id}
        end
        it "debe de estar el usuario confirmado" do
            expect(user.confirmed?).to be true
        end
        it "debe de tirar error al no tener un usuario loggeado" do
            expect(user.id).to be_kind_of(Numeric)
        end
        it "debe de retornar HTTP exitoso" do
            expect(response).to have_http_status(:success)
        end
        it "debe de retornar el tweet en el JSON" do
            json_response = JSON.parse(response.body)
            expect(json_response.keys).to  match_array(["id", "tittle","description","user_id","created_at","updated_at"])
        end
    end
end