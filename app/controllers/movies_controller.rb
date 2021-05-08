class MoviesController < ApplicationController

    #def index
    #    if !params[:title].empty?
    #        @movies = Movie.find_or_create_from_api(params[:title])
    #    else
    #        redirect_to root_path
    #    end
    #end
    def new
        @movie = Movie.new
    end

    def create
        @movie = Movie.new(movie_params)

        hash = OmdbService.new
        escaped_title = URI.escape(@movie.title)

        @movie.title = hash.get_call(escaped_title, "Title")
        @movie.year = hash.get_call(escaped_title, "Year")
        @movie.rated = hash.get_call(escaped_title, "Rated")
        @movie.genre = hash.get_call(escaped_title, "Genre")
        @movie.runtime = hash.get_call(escaped_title, "Runtime")
        @movie.poster = hash.get_call(escaped_title, "Poster")
        @movie.rated = hash.get_call(escaped_title, "Rated")
        @movie.actors = hash.get_call(escaped_title, "Actors")
        @movie.plot = hash.get_call(escaped_title, "Plot")
        @movie.imdbRating = hash.get_call(escaped_title, "imdbRating")
        @movie.director = hash.get_call(escaped_title, "Director")
        
        if @movie.save
            redirect_to @movie
        else
            render "new"
        end
    end

    def edit
        @movie = Movie.find(params[:id])
    end
    
    def update
        @movie = Movie.find(params[:id])
        @movie.update(movie_params)
    
        redirect_to @movie
    end

    def index
        @movies = Movie.all
    end

    def show
        @movie = Movie.find_by(id: params[:id])
        #@review = Review.new
        # @reviews = Review.where(movie_id: @movie.id)
        #@reviews = @movie.reviews
    end

    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
    
        redirect_to movies_path
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
