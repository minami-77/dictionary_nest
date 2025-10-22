class AddFieldsToUserWords < ActiveRecord::Migration[7.1]
  def change
    add_column :user_words, :note, :text
  end
end
