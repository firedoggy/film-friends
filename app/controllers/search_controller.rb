class SearchController < ApplicationController

    def index
        if params[:search]
            query_service = OmdbService.new
            @query = query_service.get_movies_by_title_fragment(params[:search])
            @results = @query["Search"]
            @movies = []
            # If successful, @result will be a hash
            if @result.is_a? String
                @error_message = error_response(@query.to_i)
            elsif @results != nil
                @results.each do |r|
                    @movie = Movie.find_or_create_from_api(r["imdbID"])
                    @movies << @movie
                end
            end
            render "results/index"
        else
            @results = nil
            @movies = nil
            @selected = nil
        end
    end

    def error_response(error_code)
        case error_code
            when 100..199
                return "Error #{error_code}: Request initiated by the browser is continuing."
            when 300..399
                return "Request returned #{error_code}: Redirection."
            when 400..499
                return "Client Error #{error_code}: Check the OMDB API request parameters."
            when 500...600
                return "Servor Error #{error_code}: Sorry, looks like OMDB is having a bad day."
        end
    end

end