class SessionsController < Devise::SessionsController
  before_filter :authenticate_user!

  def create
    super do |user|
      # reset_token(user)
      data = { token: user.authentication_token, email: user.email }
      render(json: data, status: 201) && return
    end
  end

  def destroy
    # reset_token(current_user)
    super
  end
end
