class User < ActiveRecord::Base

  attr_accessor :remember_token
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :first_name, presence: true, confirmation: true, length: { in: 2..15 }
  validates :last_name, presence: true, confirmation: true, length: { in: 2..15 }
  validates :password, presence: true, length: { in: 2..25 }, on: :update, allow_blank: true

  has_many :products, dependent: :delete_all
  has_many :sales, dependent: :delete_all


  def admin?
    self.role == 'Admin'
  end

  before_save :assign_role

  def assign_role
    self.role = "Buyer" if self.role.nil?
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember_me
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

end
