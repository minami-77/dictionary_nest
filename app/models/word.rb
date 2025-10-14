class Word < ApplicationRecord
  has_many :part_of_speeches, dependent: :destroy
  has_many :user_words, dependent: :destroy
  has_many :users, through: :user_words
end
