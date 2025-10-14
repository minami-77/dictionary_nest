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
    word_data = params[:word_data][:searchedResults]

    # save the word if not saved yet
    @word = Word.find_by(
      spelling: word_data[0][:word])
    if @word
      render json: {
        message: 'Word already saved',
      } and return
    else
      @word = Word.create(
        spelling: word_data[0][:word],
        pronunciation: word_data[0][:phonetic],
        language: "en"
      )
    end

    # save part of speeches and definitions if not saved yet
    if @word.part_of_speeches.empty?
      word_data.each do |data|
        data[:meanings].each do |meaning_data|
          part_of_speech = @word.part_of_speeches.create(
            part_of_speech: meaning_data[:partOfSpeech]
          )
          meaning_data[:definitions].each do |def_data|
            part_of_speech.definitions.create(
              description: def_data[:definition],
              example: def_data[:example]||"",
              synonyms: def_data[:synonyms]||[],
              antonyms: def_data[:antonyms]||[]
            )
          end
        end
      end

    else
      render json: {
        message: 'Part of speeches already saved',
      } and return
    end

    # Connect user to the word
    user = current_api_v1_user
    user_word = user.user_words.find_by(word_id: @word.id)

    if user_word.persisted?
      render json: {
        status: 'INFO',
        message: 'Word already saved',
        }, status: :ok
    else
      user_word = user.user_words.create(word_id: @word.id)
      unless user_word.persisted?
        render json: {
          status: 'ERROR',
          message: 'Did not connect the word to the user',
          user: user.errors
        }, status: :unprocessable_entity and return
      end
    end

  end
end

    # # Display result
    # if @word.persisted? && @word.part_of_speeches.present? && user_word.persisted?
    #   render json: {
    #     status: 'SUCCESS',
    #     message: 'Saved the word',
    #     word: @word,
    #     part_of_speech: @word.part_of_speeches,
    #     definition: @word.part_of_speech.definition
    #   }, status: :ok
    # else
    #   render json: {
    #     status: 'ERROR',
    #     message: 'Did not save the word',
    #     word: @word.errors
    #   }, status: :unprocessable_entity
    # end
