FactoryBot.define do
    factory :task do
      sequence(:id) { |n| "#{n}"}
      sequence(:description) {|n| "Prueba #{n}"}
      updated_at {Time.now}
      created_at {Time.now}
    end
  end