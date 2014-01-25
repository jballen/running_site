class CreateBlogPostTable < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.text :body
      t.integer :user
      t.string :title
      t.integer :team_id

      t.timestamps
    end
    add_reference :blog_posts, :user, index: true
  end
end
