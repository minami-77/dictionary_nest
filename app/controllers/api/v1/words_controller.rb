class Api::V1::WordsController < ApplicationController
# receive a inputted keyword (from react form) and pass it to WordAPI
  def index
    render json: { message: "Hello from words_controller!", query:params[:query] }
  end
end
