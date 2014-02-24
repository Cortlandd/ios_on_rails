class V1::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, only: [:create]

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user.as_json.merge(authentication_token: @user.authentication_token), status: :created
    else
      warden.custom_failure!
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end