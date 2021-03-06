class User < ApplicationRecord
	attr_accessor :remember_token
	has_many :reviews
	has_many :intersections, :through => :reviews
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 225},
										format: { with: VALID_EMAIL_REGEX }  
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	# Returns the hashdigest of the given string
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::min_cost :
																									BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end			

	# Returns a random token
	def User.new_token
		SecureRandom.urlsafe_base64
	end						

	# Remembers a user in the database for use in persistent sessions 
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Returns true if the given token matches the digest
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# Forget a user
	def forget
		update_attribute(:remember_digest, nil)
	end
end
