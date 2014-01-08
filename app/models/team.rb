class Team < ActiveRecord::Base
  has_many :users, through: :reverse_team_user_relationships, source: :user
  has_many :reverse_team_user_relationships, class_name: "TeamUserRelationship",
                                             dependent:   :destroy,
                                             foreign_key: :team_id
  has_many :captains

  # Validations
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  def member_feed
    Team.where("team_id = ?", id)
  end
end
