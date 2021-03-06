module ::Jobs
  class SyncTeachableUsers < ::Jobs::Base
    def execute(args)
      json = args[:json]
      email = json['object']['user']['email']
      invited_by = User.find_by_id(-1)
      invite = Invite.generate(invited_by, {
        email: email,
        skip_email: true
      })

      message = TeachableInviteMailer.build_invite(invite)
      Email::Sender.new(message, :invite).send
    end
  end
end



