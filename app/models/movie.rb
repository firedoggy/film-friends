class Movie < ApplicationRecord
    include Hashid::Rails

    has_many :reviews
    has_many :users, through: :reviews

    validates :title, presence: true, length: { minimum: 1 }
    serialize :omdb_data


    def self.find_or_create_from_api(query)
        #binding.pry
        movie = OmdbService.search(query)
        
        @movie = Movie.find_or_create_by(title: movie["Title"], omdb_data: movie)
    end

end
