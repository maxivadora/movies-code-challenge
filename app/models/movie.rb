# == Schema Information
#
# Table name: movies
#
#  id           :bigint(8)        not null, primary key
#  release_year :integer
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Movie < ApplicationRecord
  validates :title, :release_year, presence: true

  has_many :movie_people
  has_many :casting,
            -> { joins(:movie_people).where(movie_people: { role: MoviePerson.roles[:actor_actress] }) },
            class_name: 'Person',
            through: :movie_people,
            source: :person
  has_many :directors,
            -> { joins(:movie_people).where(movie_people: { role: MoviePerson.roles[:director] }) },
            class_name: 'Person',
            through: :movie_people,
            source: :person
  has_many :producers,
            -> { joins(:movie_people).where(movie_people: { role: MoviePerson.roles[:producer] }) },
            class_name: 'Person',
            through: :movie_people,
            source: :person
end
