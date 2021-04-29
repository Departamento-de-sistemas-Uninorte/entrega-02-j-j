FactoryBot.define do
    factory :task do
      sequence(:id) { |n| "#{n}"}
      sequence(:description) {|n| "Prueba #{n}"}
      updated_at {Time.now}
      created_at {Time.now}

      trait :invalid do
        sequence(:description) {|n| "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla blandit feugiat molestie. Curabitur non porttitor ex. Aliquam pellentesque viverra nulla, ac efficitur risus posuere id. Nam ut venenatis erat. Vestibulum egestas dignissim tortor, et porttitor mi sollicitudin sed nam."}
      end
    end
  end