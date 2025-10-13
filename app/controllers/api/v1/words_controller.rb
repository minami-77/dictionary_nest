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

    # save parts of speech and definitions
    whole_word_data = params[:word_data]
    whole_word_data.each do |word_data|
      word_data[:meanings].each do |meaning|
        meaning = @word.part_of_speeches.create(
          part_of_speech: meanings[:partOfSpeech]
        )
        category[:definitions].each do |definition|
          part_of_speech.definitions.create(
            description: definition[:definition],
            example: definition[:example],
            synonyms: definition[:synonyms].join(", ") ,
            antonyms: definition[:antonyms].join(", ")
          )
        end
      end
    end


    if @word.save && @part_of_speech.save && @definition.save
      render json: {
        status: 'SUCCESS',
        message: 'Saved the word',
        word: @word,
        part_of_speech: @word.part_of_speech,
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
