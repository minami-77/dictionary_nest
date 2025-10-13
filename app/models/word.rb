class Word < ApplicationRecord
  has_many :part_of_speeches, dependent: :destroy
end
