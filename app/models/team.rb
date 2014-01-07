class Team < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :captains

  serialize :members
  serialize :captain

  # Validations
  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
