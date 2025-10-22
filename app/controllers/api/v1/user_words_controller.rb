class Api::V1::UserWordsController < ApplicationController
  def index
    user = current_api_v1_user
    user_words = user.user_words.includes(:word)

    render json: ()

  end

  def show
  end

  def update
  end

  def destroy
  end

end
