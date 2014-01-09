class Notification < ActiveRecord::Base
  extend Enumerize
  enumerize :what, in: ['join']
  
  belongs_to :team
  validates :team_id, presence: true
  validates :user_id, presence: true
  validates :what,    presence: true
end
