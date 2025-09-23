class CreateWords < ActiveRecord::Migration[7.1]
  def change
    create_table :words do |t|
      t.string :spelling
      t.string :pronunciation
      t.string :language

      t.timestamps
    end
  end
end
