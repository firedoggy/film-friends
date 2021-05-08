class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
        t.string :title
        t.date "release_date"
        t.string "genre"
        t.integer "runtime"
        t.string "poster"
        t.string "actors"
        t.string "plot"
        t.float "imdbRating"
        t.string "director"
        t.timestamps
    end
  end
end
