class ReviewsController < ApplicationController

    before_action :redirect_if_not_review_author, only: [:edit, :update, :destroy]
    
    def index
        if params[:movie_id] && @movie = Movie.find_by_id(params[:movie_id])
            @reviews = @movie.reviews.order("created_at DESC")
        else
            @error = "That movie does not exist." if params[:movie_id]
            @reviews = Review.all.order("created_at DESC")
        end
    end

    def show
        @review = Review.find_by(id: params[:id])
        redirect_to reviews_path if !@review
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
            redirect_to movie_reviews_path(@review.movie.id)
        else
            render :new
        end
    end

    def edit
        @review = Review.find_by(id: params[:id])
        redirect_to movie_reviews_path(@review.movie.id) if !@review || @review.user != current_user
    end

    def update
        if @review.update(review_params)
            redirect_to review_path(@review)
        else
            render :edit
        end
    end

    def destroy 
        @review = Review.find_by(id: params[:id])
        @review.destroy
        redirect_to movie_url
    end

    private

    def review_params()
        params.require(:review).permit(:content, :movie_id)
    end

    def redirect_if_not_review_author
        redirect_to reviews_path if @review.user != current_user
    end

end
