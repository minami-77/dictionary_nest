class Api::V1::UserWordsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    user = current_api_v1_user
    # includes(parent:{children::grandchildren})
    user_words = user.user_words.includes(word: {part_of_speeches: :definitions})

    Rails.logger.debug "===== UserWords Debug ====="
    user_words.each do |uw|
      Rails.logger.debug "UserWord ID: #{uw.id}"
      Rails.logger.debug "Word: #{uw.word.inspect}"
      Rails.logger.debug "PartOfSpeeches: #{uw.word.part_of_speeches.inspect}"
      Rails.logger.debug "First PartOfSpeech: #{uw.word.part_of_speeches.first&.inspect}"
      Rails.logger.debug "Definitions: #{uw.word.part_of_speeches.first&.definitions&.inspect}"
    end
    Rails.logger.debug "=========================="

    render json: {
      status: 'SUCCESS',
      # .map will return a hash directly (no variables)
      # shadcn's Data table receive flatten data only (no nest allowed)
      data: user_words.map do |uw|
        {
          note: uw.note,
          status: uw.status,
          created_at:uw.created_at,
          updated_at:uw.updated_at,
          spelling: uw.word.spelling,
          pronunciation: uw.word.pronunciation,
          part_of_speech: uw.word.part_of_speeches.first&.part_of_speech,
          definition: uw.word.part_of_speeches&.first&.definitions&.first&.definition,
          example: uw.word.part_of_speeches&.first&.definitions&.first&.example
        }
      end
    }
  end


  def show
    user = current_api_v1_user
    # includes(parent:{children::grandchildren})
    user_words = user.user_words.includes(word: {part_of_speeches: :definitions})

    word = Word.find_by(spelling: params[:id])
    user_word = UserWord.find_by(word:word)

  Rails.logger.debug "===== Show Debug ====="
  Rails.logger.debug "Requested word: #{params[:id]}"
  Rails.logger.debug "Word found: #{word.inspect}"

    render json: {
      status: 'SUCCESS',
      data:
        {
          note: user_word.note,
          status: user_word.status,
          created_at:user_word.created_at,
          updated_at:user_word.updated_at,
          spelling: user_word.word.spelling,
          pronunciation: user_word.word.pronunciation,
          part_of_speeches:user_word.word.part_of_speeches.map do |pos|
              {
                part_of_speech: pos.part_of_speech,
                definitions: pos.definitions.map do |defn|
                  {
                    definition: defn.definition,
                    example: defn.example,
                    synonyms: [defn.synonyms.join(",")]||[],
                    antonyms: [defn.antonyms.join(",")]||[],
                  }
                end
              }
            end
        }
    }
  end


  def update
  end

  def destroy
  end

end
