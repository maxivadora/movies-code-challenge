class PersonSerializer < ActiveModel::Serializer
  attributes :id, :last_name, :first_name
  has_many :movies_as_director
  has_many :movies_as_actor_actress
  has_many :movies_as_producer
end
