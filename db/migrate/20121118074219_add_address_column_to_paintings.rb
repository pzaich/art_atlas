class AddAddressColumnToPaintings < ActiveRecord::Migration
  def change
    add_column :paintings, :address, :string
  end
end
