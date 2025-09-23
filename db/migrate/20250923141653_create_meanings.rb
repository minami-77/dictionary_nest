class CreateMeanings < ActiveRecord::Migration[7.1]
  def change
    create_table :meanings do |t|
      t.references :word, null: false, foreign_key: true
      t.text :definition
      t.string :part_of_speech
      t.text :example

      t.timestamps
    end
  end
end
