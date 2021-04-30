require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe "Validaciones" do
    it { should validate_presence_of(:description) }  
    it { should validate_length_of(:description).is_at_most(280) }  
  end

  describe "Asociaciones" do
    it { should belong_to(:user) }  
  end
  

end

