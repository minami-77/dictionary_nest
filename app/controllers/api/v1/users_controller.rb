class Api::V1::UsersController < ApplicationController
  # To use Devise's helper method
  # include Devise::Controllers::Helpers

  before_action :authenticate_user!

  def me
    render json: {user: current_user}
  end

end
