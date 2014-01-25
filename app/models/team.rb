class Team < ActiveRecord::Base
  has_many :blog_posts
  has_many :notifications
  has_many :users, through: :reverse_team_user_relationships, source: :user
  has_many :reverse_team_user_relationships, class_name: "TeamUserRelationship",
                                             dependent:   :destroy,
                                             foreign_key: :team_id
  serialize :captains

  # Validations
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  def member_feed
    Team.where("team_id = ?", id)
  end
  def team_captain?(other_user = current_user)
    captains.to_i == other_user.id
  end

  def delete_user(other_user)
    TeamUserRelationship.first(:conditions => 
                              ["team_id = ? AND user_id = ?", id, other_user]).destroy
  end
end
