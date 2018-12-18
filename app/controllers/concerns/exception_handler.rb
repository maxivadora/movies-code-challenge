module ExceptionHandler
  extend ActiveSupport::Concern

  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredToken < StandardError; end

  included do
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredToken, with: :four_twenty_two
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  end

  private

  def four_twenty_two(e)
    render json: { message: e.message }, status: :unprocessable_entity
  end

  def record_not_found
    render json: { error: Message.not_found }, status: :not_found
  end
end