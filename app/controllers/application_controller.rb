class ApplicationController < ActionController::API
# To use Devise's helper method
# Devise + API モード対応
  include ActionController::MimeResponds
  include ActionController::Helpers
  include Devise::Controllers::Helpers
end
