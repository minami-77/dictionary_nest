class CreateDefinitions < ActiveRecord::Migration[7.1]
  def change
    create_table :definitions do |t|
      t.references :part_of_speech, null: false, foreign_key: true
      t.text :definition
      t.text :example
      t.json :synonyms
      t.json :antonyms

      t.timestamps
    end
  end
end
