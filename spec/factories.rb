FactoryGirl.define do
  factory :task do
    trait(:with_good_content_length) { content "Testing content task" }
    trait(:with_bad_content_length) { content "ab" }
    trait(:picked) { picked 1 }
    trait(:not_picked) { picked nil }
    trait(:done) { done true }
    trait(:not_done) { done false }
    author 1
  end

  factory :user do
    email "example@example.com"
    password "example123"
    password_confirmation "example123"
  end
end