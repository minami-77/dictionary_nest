class PartOfSpeech < ApplicationRecord
  belongs_to :word
  has_many :definitions, dependent: :destroy
end
