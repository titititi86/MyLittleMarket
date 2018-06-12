class Contact < ActiveRecord::Base

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, confirmation: true, length: { in: 2..15 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :content, presence: true
  belongs_to :user

end
