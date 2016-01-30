class ApplicationController < ActionController::Base
  respond_to :html, :json
  helper_method :reset_token

  # protect_from_forgery :exception

  def reset_token(user)
    user.authentication_token = User.generate_authentication_token
  end
end
