class Invitation < ApplicationRecord
  has_secure_token
  belongs_to :user
  belongs_to :invited_by_user, :class_name => :User
  belongs_to :team

  attribute :email, :string
end
