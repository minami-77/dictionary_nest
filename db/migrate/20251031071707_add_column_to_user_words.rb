class AddColumnToUserWords < ActiveRecord::Migration[7.1]
  def change
    add_column :user_words, :status, :integer
  end
end
