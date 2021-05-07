class MoviesController < ApplicationController

    def index
        @movies = Movie.all 
    end

    def show
        @movie = Movie.find_by_id(params[:id])
        redirect_to movies_path if !@movie
    end

end
