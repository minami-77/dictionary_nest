class UserWord < ApplicationRecord
  belongs_to :user
  belongs_to :word
  enum status: {unlearned:0, learning:1, learned:2}
end
