FactoryGirl.define do
  factory :invitation do
    user_email { FFaker::Internet.email }
    team { create(:team) }
    invited_by_user { create(:user) }
  end
end
