class ApplicationController < ActionController::Base
  respond_to :html, :json
  helper_method :reset_token

  before_action :authenticate!

  # protect_from_forgery :exception

  private
    def authenticate!
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
         User.find_by(authentication_token: token)
       end
    end

    def render_unauthorized
      render json: {
        errors: ['Bad credentials']
      }, status: 401
    end

  def reset_token(user)
    user.authentication_token = User.generate_authentication_token
  end
end
