class AddRoundToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :round, :integer , default: 1
  end
end
