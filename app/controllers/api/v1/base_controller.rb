class Api::V1::BaseController < ActionController::API
  include ExceptionHandler
  before_action :authorized_request!
  
  private

  def authorized_request!
    return true unless current_user.nil?
    render json: { error: Message.unauthorized }
  end

  def current_user
    @user = (AuthService.new(request.headers).perform)[:user]
  end
end