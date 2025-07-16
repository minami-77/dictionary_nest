# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  def create
    user = User.find_by(email: params[:user][:email])

    # パスワードが正しいか確認
    if user && user.valid_password?(params[:user][:password])
      sign_in(user)  # Deviseのログイン処理
      render json: {
        status: { code: 200, message: 'Logged in successfully.' },
        data: {
          id: user.id,
          email: user.email
          # 必要ならトークンなどもここで返す
        }
      }, status: :ok
    else
      render json: {
        status: { code: 401, message: 'Invalid email or password.' }
      }, status: :unauthorized
    end
  end

  # 🚪ログアウト処理
  def destroy
    sign_out(current_user)
    render json: {
      status: { code: 200, message: 'Logged out successfully.' }
    }, status: :ok
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
end
