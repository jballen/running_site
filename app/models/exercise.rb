class Exercise < ActiveRecord::Base
  extend Enumerize
  enumerize :activity, in: [:run, :bike, :swim, :elliptical, :hike, :walk]

  belongs_to :user

  default_scope -> { order('created_at DESC') }
  validates :duration, presence: true
  validates_numericality_of :duration, :greater_than => 0
  validates :user_id, presence: true
end
