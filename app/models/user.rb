class User < ActiveRecord::Base
	before_save {self.email = email.downcase}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :name,  presence: true, length: {maximum:25}
	validates :password, length: {minimum: 6}
	validates :email, presence: true, 
					  format: {with: VALID_EMAIL_REGEX}, 
					  uniqueness: {case_sensitive: false}

	has_secure_password
end
