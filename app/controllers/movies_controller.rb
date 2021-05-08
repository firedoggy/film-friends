class MoviesController < ApplicationController

    before_action :set_movie, only: [:show, :edit, :update, :destroy]
    
    def new
        @movie = Movie.new
        @title = 'New movie'
    end

    def create
        @movie = Movie.find_or_create_from_api(movie_params)
        if @movie.save 
            redirect_to @movie
        else
            @errors = @movie.errors.full_messages
            render "new"
        end
    end

    def index
        @search = params[:search]
        if @search
            @movie = Movie.find_or_create_from_api(params[:search]) 
        else 
            @movies = Movie.all
        end 
    end

    def show
        @movie = Movie.find_by_id(params[:id])
        redirect_to movies_path if !@movie
    end

    private

    def set_movie
        @movie = Movie.find(params[:id])
    end

    def movie_params
        params.require(:movie).permit(:title)
    end
end
