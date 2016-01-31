class SessionsController < Devise::SessionsController
  before_filter :authenticate_user!
  respond_to :html, :json

  def create
    # debugger
    super do |user|
      data = { token: user.authentication_token, email: user.email }
      # debugger
      render(json: data, status: 201) && return
    end
  end
end
