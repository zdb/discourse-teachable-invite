# name: Teachable
# about:
# version: 0.2
# authors: zdb
# url: https://github.com/zdb


register_asset "stylesheets/common/teachable.scss"


enabled_site_setting :teachable_enabled

PLUGIN_NAME ||= "Teachable".freeze

after_initialize do
  
  # see lib/plugin/instance.rb for the methods available in this context

  module ::Teachable
    class Engine < ::Rails::Engine
      engine_name PLUGIN_NAME
      isolate_namespace Teachable
    end
  end
  
  require_dependency "application_controller"
  class Teachable::ActionsController < ::ApplicationController
    requires_plugin PLUGIN_NAME

    before_action :ensure_logged_in

    def list
      render json: success_json
    end
  end

  Teachable::Engine.routes.draw do
    get "/list" => "actions#list"
    post '/webhook' => 'teachable_webhook#index'
    get '/webhook' => 'teachable_webhook#index'
  end

  Discourse::Application.routes.append do
    mount ::Teachable::Engine, at: "/teachable"
  end

  [
    # '../app/controllers/teachable_admin_controller.rb',
    '../app/controllers/teachable_webhook_controller.rb',
    '../app/mailers/teachable_invite_mailer.rb',
    '../app/jobs/regular/sync_teachable_users.rb',
  ].each { |path| load File.expand_path(path, __FILE__) }
  
end
