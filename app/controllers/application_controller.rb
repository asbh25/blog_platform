# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[nickname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[nickname])
  end

  private

  def user_not_authorized
    render json: { error: 'You are not authorized to perform this action' }, status: :forbidden
  end
end
