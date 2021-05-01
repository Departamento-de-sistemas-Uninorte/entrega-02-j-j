FactoryBot.define do
    factory :user do
      sequence(:id) { |n| "#{n}"}
      sequence(:email) {|n| "test#{n}@testing.com"}
      sequence(:name) {|n| "TestUser #{n}"}
      sequence(:username) {|n| "test#{n}"}
      sequence(:password) {|n| "123456#{n}"}
      updated_at {Time.now}
      created_at {Time.now}
      jti {SecureRandom.uuid}

      trait :confirmed do
        confirmed_at {Time.now}
      end
    end
  end