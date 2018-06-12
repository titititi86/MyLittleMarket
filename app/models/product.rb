class Product < ActiveRecord::Base
  validates :title, presence: true, length: { in: 3..50 }
  validates :user, presence: true
  validates :description, length: { minimum: 2 }, allow_blank: true
  validates :price, numericality: { greater_than: 0 }, allow_blank: true

  validate :check_category

  belongs_to :user
  belongs_to :category
  has_many :sales, dependent: :delete_all


  def category_name
    category.try(:name)
  end

  def category_name=(name)
    self.category = Category.find_or_create_by(name: name) if name.present?
  end

  def check_category
    if Category.find_by(name: self.category_name) == nil
      self.errors[:category] = "is not defined"
      # else
      # self.category = Category.find_by(name: self.category_name)
    end
  end

end
