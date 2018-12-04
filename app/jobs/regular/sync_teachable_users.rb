module ::Jobs
  class SyncTeachableUsers < ::Jobs::Base
    def execute(args)
      json = args[:json]
      email = json['object']['user']['email']
      user_id = json['object']['user']['id']

      invite = Invite.create_invite_by_email(email, User.find_by_id(-1), 
        topic: nil,
        group_ids: nil,
        custom_message: nil,
        send_email: false
      )

      message = TeachableInviteMailer.send_invite(invite)
      Email::Sender.new(message, :invite).send
    end
  end
end



