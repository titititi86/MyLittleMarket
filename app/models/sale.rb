class Sale < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  # validates :user_id, length: { in: 2..25 }, allow_blank: true
end
