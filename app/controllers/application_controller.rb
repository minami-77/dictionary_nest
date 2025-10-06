class ApplicationController < ActionController::API
# To use Devise's helper method
  include Devise::Controllers::Helpers   # ✅ Deviseのhelperを明示的にinclude
  include ActionController::MimeResponds  # ✅ render json: がうまく動かない時に必要な場合も
end
