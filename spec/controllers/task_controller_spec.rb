require 'rails_helper'


RSpec.describe TasksController, "#create" do
    context "Crear y Guardar " do
        let(:user) {create(:user, :confirmed)}

        subject{ post :create, :params => {task: {tittle: "", description: "XD", user_id: user.id}}}

        before do
            sign_in user
        end
        it "debe de retornar el tweets" do
            expect(subject).to redirect_to(tasks_path)
        end
    end
    context "Recargar" do
        let(:user) {create(:user, :confirmed)}
        subject{ post :create, :params => {task: {tittle: "", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla blandit feugiat molestie. Curabitur non porttitor ex. Aliquam pellentesque viverra nulla, ac efficitur risus posuere id. Nam ut venenatis erat. Vestibulum egestas dignissim tortor, et porttitor mi sollicitudin sed nam.", user_id: user.id}}}                    
        before do
            sign_in user
        end
        
        it "debe de retornar el tweets" do
            expect(subject).to redirect_to(new_task_path)
        end
    end
end

RSpec.describe TasksController, "#index" do
    context "Mostrar" do
        let(:user) {create(:user, :confirmed)}
        subject{ post :create, :params => {task: {tittle: "", description: "XXD", user_id: user.id}}}
        subject{ post :create, :params => {task: {tittle: "", description: "XD", user_id: user.id}}}
        before do
            sign_in user
            get :index
        end
        it "debe de retornar el tweets" do
            expect(response).to have_http_status(:success)
        end
end
    
end

RSpec.describe TasksController, "#delete" do
    context "Eliminar" do
        let(:user) {create(:user, :confirmed)}
        let(:task) {create(:task, user: user)}
        before do
            sign_in user
            delete :destroy, params:{id: task.id}
        end        
        it "debe de retornar el tweets" do
            expect(response).to have_http_status(302)
        end
    end
end