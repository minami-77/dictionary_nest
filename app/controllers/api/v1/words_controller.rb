class Api::V1::WordsController < ApplicationController
  require 'net/http'
  require 'json'

  # receive searched words
  def index
    render json: {
      message: "Hello from words_controller!",
      query:params[:query]
    }
  end

  def search
    # call WordsAPI

    # These code snippets use an open-source library. http://unirest.io/ruby
    response = Unirest.get "https://wordsapiv1.p.mashape.com/words/#{params[:query]}",
    headers:{
      "X-Mashape-Key" => '******************************35d02',
      "Accept" => "application/json"
    }

    render json:{
      word: response.read_body
    }

  end

end
