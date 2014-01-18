class AddOmniauthFieldsToUsers < ActiveRecord::Migration

  def self.up
    add_column :users, :uid, :integer
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_expires_at, :datetime
  end
  def self.down
    remove_column :users, :uid
    remove_column :users, :oauth_token
    remove_column :users, :oauth_expires_at
  end
end
