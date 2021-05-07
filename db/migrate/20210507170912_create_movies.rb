class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.date :release_date
      t.string :genre
      t.integer :runtime
      t.text :plot
      t.string :rated
      t.string :director
      t.text :actors
      t.float :imdb_rating
      t.string :imdb_id

      t.timestamps
    end
  end
end
