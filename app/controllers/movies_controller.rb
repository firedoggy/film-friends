class MoviesController < ApplicationController

    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            redirect_to @movie
        else
            render "new"
        end
    end

    def index
        @movies = Movie.all.order(:title)
    end

    def show
        @movie = Movie.find_by_id(params[:id])
        redirect_to movies_path if !@movie
    end

    private

    def movie_params
        params.require(:movie).permit(:title, :omdb_data)
    end
end
