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

  has_many :movie_people
  has_many :movies, through: :movie_people
  has_many :movies_as_director,
            -> { joins(:movie_people).where(movie_people: { role: MoviePerson.roles[:director] }) },
            class_name: 'Movie',
            through: :movie_people,
            source: :movie
  has_many :movies_as_actor_actress,
            -> { joins(:movie_people).where(movie_people: { role: MoviePerson.roles[:actor_actress] }) },
            class_name: 'Movie',
            through: :movie_people,
            source: :movie
  has_many :movies_as_producer,
            -> { joins(:movie_people).where(movie_people: { role: MoviePerson.roles[:producer] }) },
            class_name: 'Movie',
            through: :movie_people,
            source: :movie
end