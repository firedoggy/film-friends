class Movie < ApplicationRecord
    include Hashid::Rails

    has_many :reviews
    has_many :users, -> { distinct }, through: :reviews

    validates :title, presence: true, length: { minimum: 1 }
    validates :imdb_id, uniqueness: true
    scope :alpha, -> { order(:title) }


    def self.find_or_create_from_api(imdb_id)
        query_service = OmdbService.new
        movie = query_service.get_movie_by_id(imdb_id)
        @movie = Movie.find_or_create_by(title: movie["Title"], 
        year: movie["Year"],
        rated: movie["Rated"],
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
