class AddAthenaeumIdToPaintings < ActiveRecord::Migration
  def change
    add_column :paintings, :athenaeum_id, :integer
    add_index :paintings, :athenaeum_id
  end
end
