# == Schema Information
#
# Table name: movie_people
#
#  id         :bigint(8)        not null, primary key
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :bigint(8)
#  person_id  :bigint(8)
#
# Indexes
#
#  index_movie_people_on_movie_id   (movie_id)
#  index_movie_people_on_person_id  (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (person_id => people.id)
#

class MoviePerson < ApplicationRecord
  belongs_to :movie
  belongs_to :person

  validates :role, uniqueness: {scope: [:person_id, :movie_id]}

  enum role: [:actor_actress, :director, :producer]
end
