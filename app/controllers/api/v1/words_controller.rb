class Api::V1::WordsController < ApplicationController
  def index
    render json: { message: "Hello from words_controller!" }
  end
end
