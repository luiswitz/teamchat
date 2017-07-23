class InvitationMailer < Devise::Mailer

  def invite_new_user(invitation)
    @invitation = invitation
    @url = "http://localhost:3000/users/sign_up?invitation=#{@invitation.token}&email=#{@invitation.user_email}"

    mail(to: @invitation.user_email, subject: "Join the #{@invitation.team.slug} team on Team Chat")
  end

  def join_team_invitation(invitation)
    @invitation = invitation
    @url = "http://localhost:3000/invitations/accept/#{@invitation.token}"

    mail(to: @invitation.user_email, subject: "Team Chat Invitation")
  end

end
