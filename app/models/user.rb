class User < ApplicationRecord
  after_create :verify_user_token

  has_many :teams
  has_many :messages
  has_many :talks, dependent: :destroy
  has_many :team_users, dependent: :destroy
  has_many :member_teams, through: :team_users, :source => :team
  has_many :invitations
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attribute :invitation_token, :string

  def my_teams
    self.teams + self.member_teams
  end

  def verify_user_token
    if self.invitation_token 
      @invitation = Invitation.find_by(user_email: self.email, token: self.invitation_token)
      @invitation.team.users << self
      @invitation.save
    end
  end
end
