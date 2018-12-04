require 'openssl'
require 'json'

class ::Teachable::TeachableWebhookController < ApplicationController

  skip_before_action :redirect_to_login_if_required, :preload_json, :check_xhr, :verify_authenticity_token

  TRIGGERS = ['sale.created']

  def index 
    unless is_valid?
      raise Discourse::InvalidAccess.new
    end
    
    case event['type'].downcase
      when 'sale.created'
        Jobs.enqueue(:sync_teachable_users, json: event)
    end

    
    render body: nil, status: 200
  end

  def event
    e = JSON.parse(request.body.read)
    raise Discourse::InvalidAccess.new unless e.kind_of?(Array)
    e.first
  end

  def is_valid?
    TRIGGERS.include?(event['type'].downcase)
  end
end
