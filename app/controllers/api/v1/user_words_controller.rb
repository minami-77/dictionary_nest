class Api::V1::UserWordsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    user = current_api_v1_user
    user_words = user.user_words.includes(:word)

    render json: {
      status: 'SUCCESS',
      data: user_words.as_json(include: :word)
    }

  end

  def show
  end

  def update
  end

  def destroy
  end

end
