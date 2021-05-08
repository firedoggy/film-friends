class Movie < ApplicationRecord
    include Hashid::Rails

    has_many :reviews
    has_many :users, through: :reviews

    validates :title, presence: true, length: { minimum: 1 }
    scope :ordered_by_title, -> { order(title: :asc) }


    def self.find_or_create_from_api(query)
        #binding.pry
        movie = OmdbService.search(query)
        
        @movie = Movie.find_or_create_by(title: movie["Title"], 
        runtime: movie["Runtime"], 
        genre: movie["Genre"], 
        release_date: movie["Released"],
        poster: movie["Poster"],
        actors: movie["Actors"],
        plot: movie["Plot"],
        imdbRating: movie["imdbRating"],
        director: movie["Director"]) 
    end

end
