class CreatePartOfSpeeches < ActiveRecord::Migration[7.1]
  def change
    create_table :part_of_speeches do |t|
      t.string :part_of_speech
      t.references :word, null: false, foreign_key: true

      t.timestamps
    end
  end
end
