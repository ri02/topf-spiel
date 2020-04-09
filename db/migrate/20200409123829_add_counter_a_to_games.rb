class AddCounterAToGames < ActiveRecord::Migration[5.2]
  def change
     add_column :games, :counter_a, :integer , default: 0
  end
end
