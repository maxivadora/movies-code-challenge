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
  has_many :directors,
            -> { where(movie_people: { role: MoviePerson.roles[:director] }) },
            class_name: 'Person',
            source: :person,
            through: :movie_people

  has_many :producers,
            -> { where(movie_people: { role: MoviePerson.roles[:producer] }) },
            class_name: 'Person',
            through: :movie_people,
            source: :person

  scope :search, ->(text){ where("title LIKE ?", "%#{text}%") }

  def roman_release_year
    number_to_roman(self.release_year)
  end
  
  def number_to_roman(original_number)
    roman_map = {
      1000 => "M",
      900 => "CM",
      500 => "D",
      400 => "CD",
      100 => "C",
      90 => "XC",
      50 => "L",
      40 => "XL",
      10 => "X",
      9 => "IX",
      5 => "V",
      4 => "IV",
      1 => "I"
    } 
    result = ""
    number = original_number

    roman_map.keys.each do |divisor|
      quotient, modulus = number.divmod(divisor)
      result << roman_map[divisor] * quotient
      number = modulus
    end
    result
  end
end