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
          spelling: uw.word.spelling,
          pronunciation: uw.word.pronunciation,
          part_of_speech: uw.word.part_of_speeches.first&.part_of_speech,
          definition: uw.word.part_of_speeches&.first&.definitions&.first&.definition,
          example: uw.word.part_of_speeches&.first&.definitions&.first&.example

          # part_of_speeches:
          #   uw.part_of_speeches.map do |pos|
          #     {
          #       part_of_speech: pos.part_of_speech
          #     }
          #     pos.map do |definition|
          #       {
          #         definition: definition.definition,
          #         example: definition.example,
          #         synonyms: [definition.synonyms.join(",")],
          #         antonyms: [definition.antonyms.join(",")]
          #       }
          #     end
          # end
        }

      end

    }
  end


  def show
  end

  def update
  end

  def destroy
  end

end
