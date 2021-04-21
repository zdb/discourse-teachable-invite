require 'openssl'
require 'json'

class ::Teachable::TeachableWebhookController < ApplicationController

  skip_before_action :redirect_to_login_if_required, :preload_json, :check_xhr, :verify_authenticity_token

  TRIGGERS = ['enrollment.created']
  COURSES = [302950]

  def index 
    if is_valid?
      case event['type'].downcase
        when 'enrollment.created'
          Jobs.enqueue(:sync_teachable_users, json: event)
          return render body: nil, status: 200
      end
    end

    return render body: nil, status: 400
  end

  def event
    e = JSON.parse(request.body.read)
    raise Discourse::InvalidAccess.new unless e.kind_of?(Array)
    e.first
  end

  def is_valid?
    TRIGGERS.include?(event['type'].downcase) and 
    COURSES.include?(event['object']['course_id'])
  end
end
