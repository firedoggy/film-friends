class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :rating
      t.references :user, foreign_key: true
      t.references :movie, foreign_key: true

      t.timestamps
    end
  end
end
