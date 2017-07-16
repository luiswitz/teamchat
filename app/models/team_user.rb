class TeamUser < ApplicationRecord
  belongs_to :team
  belongs_to :user
  validates_presence_of :team, :user
  validates_uniqueness_of :user_id, :scope => :team_id

  attribute :email, :string

  before_validation :set_user_id, if: :email?

  def set_user_id
    self.user = User.invite!(email: email)
  end
end
