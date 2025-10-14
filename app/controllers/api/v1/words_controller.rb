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

    @word = Word.new(
      spelling: word_data[0][:word],
      pronunciation: word_data[0][:phonetic],
      language: "en"
      )

    # save part of speeches and definitions
    word_data.each do |data|
      data[:meanings].each do |meaning_data|
        part_of_speech = @word.part_of_speeches.new(
          part_of_speech: meaning_data[:partOfSpeech]
        )
        category[:definitions].each do |def_data|
          part_of_speech.definitions.new(
            description: def_data[:definition],
            example: def_data[:example]||"",
            synonyms: def_data[:synonyms]||[],
            antonyms: def_data[:antonyms]||[]
          )
        end
      end
    end

    # Connect user to the word





    # Display result
    if @word.save && @part_of_speech.save && @definition.save
      render json: {
        status: 'SUCCESS',
        message: 'Saved the word',
        word: @word,
        part_of_speech: @word.part_of_speeches,
        definition: @word.part_of_speech.definition
      }, status: :ok
    else
      render json: {
        status: 'ERROR',
        message: 'Did not save the word',
        word: @word.errors
      }, status: :unprocessable_entity
    end

  end

end
