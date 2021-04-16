module ::Jobs
  class SyncTeachableUsers < ::Jobs::Base
    def execute(args)
      json = args[:json]
      email = json['object']['user']['email']
      user_id = json['object']['user']['id']

      invited_by = User.find_by_id(-1)
      invite = Invite.generate(invited_by, {
        email: email,
        send_email: false
      })

      message = TeachableInviteMailer.send_invite(invite)
      Email::Sender.new(message, :invite).send
    end
  end
end



