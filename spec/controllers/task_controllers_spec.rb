require 'rails_helper'

RSpec.describe TasksController, "#create" do
  context "When quieres hacer un Tweet, but llega un params misterioso invalido" do
    it "y no te deja guardarlo en la BD y tira un error" do 
        expect {Task.create!}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context "Debe de crearse exitosamente el tweet" do
    before do
      post :create, params: {task: {
          description: "Prueba de RSpec",
          user_id: 1
      }}
    end
      it "y guardarse con todos los datos necesarios" do
          expect(Task.last.description).to match("Prueba de RSpec")
      end
  end
  
end
