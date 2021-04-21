module ::Jobs
  class SyncTeachableUsers < ::Jobs::Base
    def execute(args)
      json = args[:json]
      email = json['object']['user']['email']
      user_id = json['object']['user']['id']

      # https://github.com/discourse/discourse/blob/master/app/models/invite.rb
      invited_by = User.find_by_id(-1)
      invite = Invite.generate(invited_by, {
        email: email,
        skip_email: true
      })

      TeachableInviteMailer.send_invite(invite)
    end
  end
end



