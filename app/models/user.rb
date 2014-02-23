class User < ActiveRecord::Base
  has_many :day_items
  has_many :exercises, dependent: :destroy
  has_many :exercise_comments
  has_many :team_user_relationships, foreign_key: :user_id,
                                     dependent:   :destroy
  has_many :teams, through: :team_user_relationships,
                   source:  :team
  belongs_to :team

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  before_save :downcase_email
  before_create :create_remember_token
  validates :name,  presence: true, length: {maximum:25}, if: :site_login?  
  validates :password, length: {minimum: 6}, if: :site_login?  
  validates :email, presence: true, 
      format: {with: VALID_EMAIL_REGEX}, 
      uniqueness: {case_sensitive: false}, if: :site_login?  
  # Turn off validations for the facebook login
	has_secure_password validations: false
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def feed
    Exercise.team_member_activity(self)
  end

  def on_team?(other_team)
    team_user_relationships.find_by(team_id: other_team.id)
  end

  def join_team!(other_team)
    team_user_relationships.create!(team_id: other_team.id)
  end

  def quit_team!(other_team)
    team_user_relationships.find_by(team_id: other_team.id).destroy!
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.image_link = auth.info.image
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def logged_in_with(provider)
    return self.provider == provider
  end

  private
    def site_login?
      password.present?
    end
    def downcase_email
      if site_login? 
        self.email = email.downcase 
      end
    end
    def create_remember_token
      if site_login?
        self.remember_token = User.encrypt(User.new_remember_token)
      end
    end
end
