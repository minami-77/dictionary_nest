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
    note = params[:word_data][:note]

    # 1. create word if not saved yet
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

    # 2. create part of speeches and definitions if not saved yet
    if @word.part_of_speeches.empty?
      word_data.each do |data|
        data[:meanings].each do |meaning_data|
          part_of_speech = @word.part_of_speeches.create(
            part_of_speech: meaning_data[:partOfSpeech]
          )
          meaning_data[:definitions].each do |def_data|
            part_of_speech.definitions.create(
              definition: def_data[:definition],
              example: def_data[:example]||"",
              synonyms: def_data[:synonyms]||[],
              antonyms: def_data[:antonyms]||[]
            )
          end
        end
      end
    end

    # 3. create UserWord to link word to the current user
    user = current_api_v1_user
    user_word = user.user_words.find_or_initialized_by(word: @word)

    # save note and respond accordingly
    if user_word.new_record?
      user_word.note = note
      user_word.save

      render json: {
        status: 'SUCCESS',
        message: 'Saved the word',
        }, status: :created
    else
    # update note if already exists
      user_word.update(note: note)

      render json: {
        status: 'SUCCESS',
        message: 'Word already saved. note Updated.',
      }, status: :ok
    end

# Standard error handling
  rescue => e
  render json: {
    status: 'ERROR',
    message: '予期しないエラーが発生しました',
    error: e.message
  }, status: :internal_server_error
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
