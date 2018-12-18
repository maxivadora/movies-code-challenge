class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :roman_release_year
  has_many :casting
  has_many :directors
  has_many :producers
end