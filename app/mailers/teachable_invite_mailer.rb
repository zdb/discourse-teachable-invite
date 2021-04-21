require_dependency 'email/message_builder'

class TeachableInviteMailer < ActionMailer::Base
  include Email::BuildEmailHelper

  def send_invite(invite)
  	message = build_email(
  		invite.email,
		template: 'teachable_invite_mailer',
		site_domain_name: Discourse.current_hostname,
		site_title: SiteSetting.title,
		site_description: SiteSetting.site_description,
	    invite_link: "#{Discourse.base_url}/invites/#{invite.invite_key}"
	)
	
	Email::Sender.new(message, :invite).send	
  end
end