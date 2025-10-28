class Api::V1::UserWordsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    user = current_api_v1_user
    user_words = user.user_words.includes(word: {part_of_speech: :definition})

    render json: {
      status: 'SUCCESS',
      data: user_words.map do |uw|
        {
          id: uw.id,
          note: note,
          name: uw.word.name,
          word: uw.word.spelling,
          pronunciation: uw.word.pronunciation,
          part_of_speeches:
            uw.part_of_speech.map do |pos|
              {
                part_of_speech: pos.part_of_speech
              }
              pos.map do |definition|
                {
                  definition: definition.definition,
                  example: definition.example,
                  synonyms: [definition.synonyms.join(",")],
                  antonyms: [definition.antonyms.join(",")]
                }
              end
          end
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
