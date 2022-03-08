# The ApplicationController  is the main controller that inherits from ActionController.

class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Permitted parameters for User account creation and update.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email contact address role password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name email contact address role password])
  end
end
