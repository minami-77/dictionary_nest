class Api::V1::WordsController < ApplicationController

  # receive searched words
  def index
    render json: {
      message: "Hello from words_controller!",
      query:params[:query]
    }
  end

  def create()
    render json:{word_data: params[:word_data]
    }
    @word = Word.new(params[:word_data])
    @word.spelling = params[:word_data][:word]
    @word.pronunciation = params[:word_data][:phonetic]
    @word.language = "en"
    # @word.user_id = current_user.id

    if @word.save
      render json: {status: 'SUCCESS', message: 'Saved the word', data: @word_data}, status: :ok
    else
      render json: {status: 'ERROR', message: 'Did not save the word', data: @word_data.errors}, status: :unprocessable_entity
    end
  end

end
