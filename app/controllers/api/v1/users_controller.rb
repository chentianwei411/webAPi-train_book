class Api::V1::UsersController < ApiController
  before_action :authenticate_user!

  def show
    render :json => {
      :email => current_user.email,
      :image => current_user.image,
      :updated_at => current_user.updated_at,
      :created_at => current_user.created_at
    }
  end

  def update
    if current_user.update(user_params)
      render :json => { :message => "ok"}
    else
      render :json => { :message => "Failed", :errors => current_user.errors }, :status => 400
    end
  end

  protected

  def user_params
    params.permit(:email, :password, :image)
  end
end
