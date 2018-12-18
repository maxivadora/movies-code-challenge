class Api::V1::BaseController < ActionController::API
  include ExceptionHandler
  before_action :authorized_request!
  # rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  
  private
  # def record_not_found
  #   render json: { error: Message.not_found }, status: :not_found
  # end

  def authorized_request!
    return true unless current_user.nil?
    render json: {error: Message.unauthorized}
  end

  def current_user
    return nil unless decoded_token
    @user ||= User.find_by(id: decoded_token[:user_id]) unless decoded_token.empty?
  end

  def decoded_token
    return {} unless http_auth_header
    @decoded_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if request.headers['Authorization'].present?
      return request.headers['Authorization'].split(' ').last
    end
    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end

end