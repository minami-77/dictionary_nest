class Api::V1::WordsController < ApplicationController
  def index
    render json: { message: "Hello from words_controller!", query:params[:query] }
  end
end
