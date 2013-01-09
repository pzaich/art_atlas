class AddAttachmentImageToPaintings < ActiveRecord::Migration
  def self.up
    change_table :paintings do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :paintings, :image
  end
end
