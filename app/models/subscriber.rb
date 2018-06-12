class Subscriber < ActiveRecord::Base
  validates :name, :email, :source, presence: true
end
