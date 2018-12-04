module ::Jobs
  class SyncTeachableUsers < ::Jobs::Base
    def execute(args)
      json = args[:json]
      email = json['object']['user']['email']
      user_id = json['object']['user']['id']

      Invite.create(email: email, invited_by: User.find_by_id(-1))
    end
  end
end