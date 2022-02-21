# --Schema information--
# Table name = posts
# title        :string
# description  :string
# image        :string
# sport_id     :bigint
# created_at   :datetime, null: false
# updated_at   :datetime, null: false
# user_id      
#
class Post < ApplicationRecord
  #Associations
  belongs_to :sport
  belongs_to :user
  has_many :anouncements
  # validations
  validates :title, :description, presence: true
end
