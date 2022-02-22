class AchievementSerializer < ActiveModel::Serializer
  attributes :id, :award, :medal
  # associations
  belongs_to :user
  belongs_to :sport
end
