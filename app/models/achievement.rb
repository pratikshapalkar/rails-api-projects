# --Schema information--
# Table name = achievements
# award       :string
# medals      :string
# sport_id    :bigint
# user_id     :bigint
# created_at  :datetime, null: false
# updated_at  :datetime, null: false
# 
class Achievement < ApplicationRecord
  # Associations
  belongs_to :sport
  belongs_to :user
  # validations
  validates :award, :medals, presence: true
end
