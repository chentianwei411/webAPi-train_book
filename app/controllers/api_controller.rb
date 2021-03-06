class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :authentication_user_from_token!
  before_action :set_default_format

  def set_default_format
    request.format = :json
  end

  def authentication_user_from_token!
    if params[:auth_token].present?
      user = User.find_by(authenication_token: params[:auth_token])
      sign_in(user, store: false) if user
    end
  end
end
