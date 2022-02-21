# --Schema information--
# Table name = anouncements
# description    :string
# sport_id       :bigint
# created_at     :datetime, null: false
# updated_at     :datetime, null: false
# 
class Anouncement < ApplicationRecord
  # Associations
  belongs_to :sport
  belongs_to :post
  # Validations
  validates :description, presence: true
end
