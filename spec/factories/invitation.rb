FactoryGirl.define do
  factory :invitation do
    user { create(:user) }
    team { create(:team) }
    invited_by_user { create(:user) }
  end
end
