class ApplicationController < ActionController::API
# To use Devise's helper method
# Devise + API モード対応
  include ActionController::MimeResponds
  include ActionController::Helpers
  include Devise::Controllers::Helpers

  # alias to use shorter method names in controllers
  alias_method :authenticate_user!, :authenticate_api_v1_user!
  alias_method :current_user, :current_api_v1_user

end
