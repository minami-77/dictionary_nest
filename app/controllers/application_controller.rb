class ApplicationController < ActionController::API
# To use Devise's helper method
  include Devise::Controllers::Helpers

# To allow name parameter
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end

# alias to use shorter method names in controllers
  # alias_method :authenticate_user!, :authenticate_api_v1_user!
  # alias_method :current_user, :current_api_v1_user

end
