class V1::SessionsController < ::Devise::SessionsController
  respond_to :json

  def create
    @user = User.where(user_params).first

    if @user.valid_password?(params[:user][:password])
      @user.authentication_token = ''
      @user.ensure_authentication_token
      render json: @user.as_json.merge(authentication_token: @user.authentication_token)
    else
      render json: 'Unauthorized', status: :unauthorized
    end
  end

  def destroy
    current_user.authentication_token = nil
    super
  end

  protected

  def verified_request?
    request.content_type == 'application/json' || super
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end