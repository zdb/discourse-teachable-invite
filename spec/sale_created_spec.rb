# require 'rails_helper'
# require_relative 'spec_helper'

# RSpec.describe ::Teachable::User do
#   include_context "spec helper"

#   before do
#     content = { status: 200, headers: { "Content-Type" => "application/json" } }
#     sale_created = content.merge(body: get_teachable_response('sale_created.json'))
#     SiteSetting.teachable_enabled = true
#   end

#   it "should create a new user after sale" do
#     expect {
#       described_class.create!
#     }.to change { User.count }.by(1)
#   end

# end
