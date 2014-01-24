class CreateTeamBlogs < ActiveRecord::Migration
  def change
    create_table :team_blogs do |t|
      t.text :post
      t.references :team, index: true
      t.string :user_id
      t.string :integer
      t.string :title

      t.timestamps
    end
  end
end
