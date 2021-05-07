class Movie < ApplicationRecord

    has_many :reviews
    has_many :users, through: :reviews

    validates :title, presence: true, length: { minimum: 1 }
    serialize :omdb_data

    def omdb(attribute)
        if self.omdb_data
            self.omdb_data[attribute]
        else
            ''
        end
    end

end
