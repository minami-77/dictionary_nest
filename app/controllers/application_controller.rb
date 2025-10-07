class ApplicationController < ActionController::API
# To use Devise's helper method
  include Devise::Controllers::Helpers

  # alias to use shorter method names in controllers
  alias_method :authenticate_user!, :authenticate_api_v1_user!
  alias_method :current_user, :current_api_v1_user

end
