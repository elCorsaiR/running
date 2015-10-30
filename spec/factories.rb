FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@example.org" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
end