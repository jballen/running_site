class AddImageLinkToUserss < ActiveRecord::Migration
  def self.up
    add_column :users, :image_link, :string
  end
  def self.down
    remove_column :users, :image_link
  end
end
