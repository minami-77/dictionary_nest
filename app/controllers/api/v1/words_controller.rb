class Api::V1::WordsController < ApplicationController
# receive searched words
  def index
    render json: { message: "Hello from words_controller!", query:params[:query] }
  end

  def search

  end
end
