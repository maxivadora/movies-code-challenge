class CreateMoviePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_people do |t|
      t.references :movie, foreign_key: true
      t.references :person, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
