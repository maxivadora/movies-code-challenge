class AuthService
  def initialize(headers = {})
    @headers = headers
  end

  def perform
    {
      user: user
    }
  end

  private

  def user
    @user ||= User.find_by(id: decoded_token[:user_id]) if decoded_token
  end

  def decoded_token
    @decoded_token ||= JsonWebToken.decode(http_auth_header) unless http_auth_header.nil?
  end

  def http_auth_header
    if @headers['Authorization'].present?
      return @headers['Authorization'].split(' ').last
    end
  end
end