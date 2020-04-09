class AddGroupnameToGames < ActiveRecord::Migration[5.2]
  def change
     add_column :games, :groupname, :string , default: 'a'
  end
end
