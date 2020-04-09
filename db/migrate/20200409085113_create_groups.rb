class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.integer :counter, default: 0
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
