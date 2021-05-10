class MoviesController < ApplicationController

    def index
        #binding.pry
        @movies = Movie.all.alpha
    end

    def show
        @movie = Movie.find_by_id(params[:id])
        redirect_to movies_path if !@movie
    end

    private

    def movie_params
        params.require(:movie).permit(:title, 
        :year, 
        :rated,
        :genre,
        :runtime,
        :poster,
        :actors,
        :plot,
        :imdbRating,
        :imdb_id,
        :director)
    end 
end
