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

  has_many :movie_people, dependent: :delete_all
  has_many :people, through: :movie_people
  has_many :casting,
            -> { where(movie_people: { role: MoviePerson.roles[:actor_actress] }) },
            class_name: 'Person',
            through: :movie_people,
            source: :person
  
  [:director, :producer].each do |role|
    has_many "#{role}s".to_sym,
              -> { where(movie_people: { role: MoviePerson.roles[role] }) },
              class_name: 'Person',
              through: :movie_people,
              source: :person
  end

  scope :search, ->(text){ where("title LIKE ?", "%#{text}%") }

  def roman_release_year
    Utils.number_to_roman(self.release_year)
  end
end