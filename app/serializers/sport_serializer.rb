class SportSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image
  # associations
  belongs_to :user
  belongs_to :sport
end
