class V1::SessionsController < Devise::SessionsController
  skip_before_filter :authenticate_user!

  def destroy
    current_user.authentication_token = nil
    super
  end

  protected

  def verified_request?
    request.content_type == 'application/json' || super
  end
end