class Category < ActiveRecord::Base
  has_many :category
  has_many :subcategories, :class_name => "Category", :foreign_key => :parent_id, :dependent => :destroy
  has_one :parent, :class_name => "Category", :primary_key => :parent_id, :foreign_key => :id
  # belongs_to :parent_category, :class_name => "Category"


  def parent_name
    # it may not have a parent
    parent.try(:name)
  end

  def has_parent?
    parent.present?
  end

  def has_subcategories?
    subcategories.exists?
  end
end
