class Exercise < ActiveRecord::Base
  extend Enumerize
  enumerize :activity, in: [:run, :bike, :swim, :elliptical, :hike, :walk, :nordicskiing]
  enumerize :unit, in: [:mile, :km]
  belongs_to :user
  belongs_to :day_item  
  has_many :exercise_comments
  accepts_nested_attributes_for :exercise_comments
  
  default_scope -> { order('created_at DESC') }
  validates :duration, presence: true
  validates_numericality_of :duration, :greater_than_or_equal_to => 0
  validates_numericality_of :distance, :greater_than_or_equal_to => 0, if: :distance_present?
  validates :user_id, presence: true

  def self.team_member_activity(user)
    team_member_ids = []
    user.teams.each do |team|
      team_member_ids << team.users.map(&:id)
    end
    team_member_ids << user.id
    team_member_ids = team_member_ids.flatten
    team_member_ids = team_member_ids.uniq.flatten
    where("user_id IN (:team_member_ids)", 
          team_member_ids: team_member_ids)
  end

  private

    def distance_present?
      distance.present?
    end
end
