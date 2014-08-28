class Product < ActiveRecord::Base
  validates_presence_of :name, :description, :price
  validates :name, uniqueness: true
end
