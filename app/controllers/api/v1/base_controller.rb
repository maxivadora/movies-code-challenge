class Api::V1::BaseController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  # before_action :force_json
  
  private
  # def force_json
  #   request.format = :json
  # end
  def record_not_found
    render json: { error: 'Record not found' }, status: :not_found
  end
end