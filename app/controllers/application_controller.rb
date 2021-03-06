class ApplicationController < ActionController::Base
  before_filter :authenticate_user_from_token!

  after_filter :set_csrf_cookie

  def set_csrf_cookie
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  private

  def authenticate_user_from_token!
    authenticate_with_http_token do |token, _options|
      User.find_by(authentication_token: token)
    end
  end
end
