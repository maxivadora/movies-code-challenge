# == Schema Information
#
# Table name: people
#
#  id         :bigint(8)        not null, primary key
#  aliases    :string
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Person < ApplicationRecord
  validates :last_name, :first_name, :aliases, presence: true

  has_many :movie_people, dependent: :delete_all
  has_many :movies, through: :movie_people
  [:director, :actor_actress, :producer].each do |role|
    has_many "movies_as_#{role}".to_sym,
              -> { where(movie_people: { role: MoviePerson.roles[role] }) },
              class_name: 'Movie',
              through: :movie_people,
              source: :movie
  end
  
  def full_name
    "#{last_name.capitalize}, #{first_name.capitalize}"
  end
end
