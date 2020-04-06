class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :text
      t.references :game, foreign_key: true
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
