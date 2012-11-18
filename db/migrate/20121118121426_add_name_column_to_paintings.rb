class AddNameColumnToPaintings < ActiveRecord::Migration
  def change
    add_column :paintings, :name, :string
  end
end
