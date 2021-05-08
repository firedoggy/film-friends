class Movie < ApplicationRecord
    include Hashid::Rails

    has_many :reviews
    has_many :users, through: :reviews

    validates :title, presence: true, length: { minimum: 1 }
    scope :ordered_by_title, -> { order(title: :asc) }


    def self.find_or_create_from_api(id)
        #binding.pry
        query_service = OmdbService.new
        movie = query_service.get_movie_by_id(id)
        @movie = Movie.find_or_create_by(title: movie["Title"], 
        release_date: movie["Year"],
        genre: movie["Genre"], 
        runtime: movie["Runtime"], 
        poster: movie["Poster"],
        plot: movie["Plot"],
        director: movie["Director"],
        actors: movie["Actors"],
        imdbRating: movie["imdbRating"],
        imdb_id: movie["imdbID"]
        ) 
    end

end
