class ReviewsController < ApplicationController
    
    def index
        @reviews = Review.all
    end

    def show
        @review = Review.find_by(id: params[:id])
    end

    def new
        @review = Review.new
    end

    def create
        @review = Review.ner(reivew)
    end

    private

    def review_params()
        params.require(:review).permit(:content)
    end
    
end
