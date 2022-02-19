#   Schema information
#  Table name = Products
#   name        :string
#   brand       :string
#   price       :string
#   description :string
#   created_at, :datetime,  null: false
#   updated_at, :datetime,  null: false


class Product < ApplicationRecord
  # Associations
  has_many :categories, dependent: :destroy
  has_many :users, dependent: :destroy
end
