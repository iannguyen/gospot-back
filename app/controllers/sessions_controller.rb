class SessionsController < Devise::SessionsController
  before_filter :authenticate_user!
  respond_to :html, :json

  def create
    if params[:user][:email] == 'guest'
      render(json: find_guest, status: 201) && return
    end
    super do |user|
      data = { token: user.authentication_token, email: user.email }
      render(json: data, status: 201) && return
    end
  end

  def find_guest
    guest_users = User.where('email ~* ?', '.*guest').all
    guest_user = guest_users.find { |user| user.bets == [] }
    data = { token: guest_user.authentication_token, email: guest_user.email }
  end
end
