require 'rails_helper'

RSpec.describe TasksController, "#create" do
    let(:user) {create(:user, :confirmed)}

    subject{ post :create, :params => {tittle: "", description: "XD", user_id: user.id}}

    context "Crear y Guardar " do
        it "debe de retornar el tweets" do
            expect(subject).to redirect_to(tasks_path)
        end
    end

    context "Crear y No guardar" do
        it "debe de retornar el tweets" do
            expect(subject).to redirect_to("taks/new")
        end
    end
end

RSpec.describe TasksController, "#index" do

    
end

RSpec.describe TasksController, "#delete" do
    
end