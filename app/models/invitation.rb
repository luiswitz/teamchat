class Invitation < ApplicationRecord
  after_create :send_mail
  
  has_secure_token
  belongs_to :invited_by_user, :class_name => :User
  belongs_to :team

  validates_presence_of :user_email

  def user_exists?
    !!User.find_by(email: self.user_email)
  end


  def accept
    self.accepted_at = DateTime.now
  end

  def send_mail
    if self.user_exists?
      InvitationMailer.join_team_invitation(self).deliver_now
    else
      InvitationMailer.invite_new_user(self).deliver_now
    end
  end
end
