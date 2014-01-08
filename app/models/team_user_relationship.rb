class TeamUserRelationship < ActiveRecord::Base
  # class_name is unnecessary in these cases, but included for readability
  belongs_to :user, class_name: "User"  
  belongs_to :team, class_name: "Team" 
  validates :user_id, presence: true
  validates :team_id, presence: true
end
