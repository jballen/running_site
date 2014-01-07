class User < ActiveRecord::Base
  has_many :exercises, dependent: :destroy
  has_many :captains
  has_many :relationships, dependent: :destroy
  has_many :teams, through: :team_user_relationships
  belongs_to :team
	
  before_save {self.email = email.downcase}
  before_create :create_remember_token
  
  serialize :teams
	
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :name,  presence: true, length: {maximum:25}
	validates :password, length: {minimum: 6}
	validates :email, presence: true, 
					  format: {with: VALID_EMAIL_REGEX}, 
					  uniqueness: {case_sensitive: false}

	has_secure_password
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def feed
    # The ? ensures that id is properly escaped to avoid SQL injection
    Exercise.where("user_id = ?", id)
  end

  def on_team?(other_team)
    team_user_relationships.find_by(team_id: other_team.id)
  end

  def join_team!(other_team)
    team_user_relationships.create!(team_id: other_team.id)
  end

  def leave_team!(other_team)
    team_user_relationships.find_by(team_id: other_team.id)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
