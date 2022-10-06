class ApplicationController < ActionController::API
  include ActionController::Cookies

  wrap_parameters format: []
  before_action :authorize
  rescue_from ActiveRecord::RecordInvalid, with: :response_to_unprocessable_entity

  # Private methods 

  private 
  def authorize 
    render json: {errors: ["Not authorized"]}, status: :unauthorized unless session.include? :user_id
  end

  # Method to catch invalid entries
  def response_to_unprocessable_entity(err) 
    render json: {errors: err.record.errors.full_messages}, status: :unprocessable_entity
  end
end
