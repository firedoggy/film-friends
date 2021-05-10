class ReviewsController < ApplicationController
    
    def index
        if params[:movie_id] && @movie = Movie.find_by_id(params[:movie_id])
            @reviews = @movie.reviews
        else
            @error = "That movie does not exist." if params[:movie_id]
            @reviews = Review.all
        end
    end

    def show
        #@review = Review.find_by(id: params[:id])
    end

    def new
        #binding.pry
        if params[:movie_id] && @movie = Movie.find_by_id(params[:movie_id])
            @review = @movie.reviews.build
        else
            @error = "That movie does not exist." if params[:movie_id]
            @review = Review.new
        end
    end

    def create
        @review = current_user.reviews.build(review_params)
        if @review.save
            redirect_to review_path(@review)
        else
            render :new
        end
    end

    def update
        if @review.update(review_params)
            redirect_to review_path(@review)
        else
            render :edit
        end
    end

    private

    def review_params()
        params.require(:review).permit(:content, :movie_id)
    end

end
