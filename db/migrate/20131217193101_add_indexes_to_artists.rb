class AddIndexesToArtists < ActiveRecord::Migration
  def change
    add_index :artists, :name
  end
end
