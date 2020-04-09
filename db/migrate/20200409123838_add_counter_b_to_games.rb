class AddCounterBToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :counter_b, :integer , default: 0
  end
end
