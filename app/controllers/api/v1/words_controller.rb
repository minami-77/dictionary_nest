class Api::V1::WordsController < ApplicationController

  # receive searched words
  def index
    render json: {
      message: "Hello from words_controller!",
      query:params[:query]
    }
  end

  def create
    # receive word data from frontend
    # expect to receive a hash with keys: word, phonetic, meanings
    word_data = params[:word_data][:searchedResults][0]
    @word = Word.new(
      spelling: word_data[:word],
      pronunciation: word_data[:phonetic],
      language: "en"
      )

    if @word.save
      render json: {
        status: 'SUCCESS',
        message: 'Saved the word',
        data: @word
      }, status: :ok
    else
      render json: {
        status: 'ERROR',
        message: 'Did not save the word',
        data: @word.errors
      }, status: :unprocessable_entity
    end
  end

end
