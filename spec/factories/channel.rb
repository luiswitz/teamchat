FactoryGirl.define do
  factory :channel do
    slug { FFaker::Lorem.word }
    team :dependent => :destroy
    user { team.user }
  end
end
