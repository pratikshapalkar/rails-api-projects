# --Schema information--
# Table name = sports
# name         :string
# no_of_player :string
# created_at   :datetime, null: false
# updated_at   :datetime, null: false
# 
class Sport < ApplicationRecord
  #Associations
  has_many :users, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :anouncements, dependent: :destroy
  has_many :achievements, dependent: :destroy
  # validations
  validates :name, :no_of_player, presence: true
end
