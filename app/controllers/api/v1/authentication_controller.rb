class Api::V1::AuthenticationController < Api::V1::BaseController
  skip_before_action :authorized_request!, only: [:login]
  
  def login
    user = User.find_by(email: login_params[:email].to_s.downcase)
  
    if user && user.authenticate(login_params[:password])
      auth_token = JsonWebToken.encode(user_id: user.id)
      render json: {auth_token: auth_token}, status: :ok
    else
      render json: {error: Message.invalid_credentials}, status: :unauthorized
    end
  end

  private
  
  def login_params
    params.permit(:email, :password)
  end
end
