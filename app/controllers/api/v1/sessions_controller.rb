# frozen_string_literal: true

class Api::V1::SessionsController < Devise::SessionsController
  # Include controllers> concern> rack_sessions_fix.rb
  include RackSessionsFix
  respond_to :json

  def create
    email = params[:user][:email]
    password = params[:user][:password]
    Rails.logger.info "ログイン試行: email=#{email}"

    user = User.find_by(email: email)
    if user.nil?
      Rails.logger.info "→ 該当ユーザーが存在しません"
    elsif !user.valid_password?(password)
      Rails.logger.info "→ パスワードが違います"
    else
      Rails.logger.info "→ ログイン成功！"
    end

    super
  end

  private
  # override original respond_with method (in create method)
  def respond_with(current_api_v1_user, _opts = {})
    if resource.present?
        render json: {
          status: {
            code: 200, message: 'Logged in successfully.',
            data: { user: UserSerializer.new(current_api_v1_user).serializable_hash[:data][:attributes] }
          }
        }, status: :ok
    else
      render json: {
        status: {message: "Log in failed. #{current_api_v1_user.errors.full_messages.to_sentence}"}
        }, status: :unauthorized
    end
  end

  # override original respond_on_destroy method
  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
      current_api_v1_user = User.find(jwt_payload['sub'])
    end

    if current_api_v1_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

end


  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
