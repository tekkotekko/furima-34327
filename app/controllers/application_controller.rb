class ApplicationController < ActionController::Base
  before_action :basic_auth

  private
  def basic_auth
    authenticate_or_request_with_http_basic do |user, pass|
      user==ENV["FURIMA_AUTH_USER"] && pass==ENV["FURIMA_AUTH_PASSWORD"]
    end
  end

end
