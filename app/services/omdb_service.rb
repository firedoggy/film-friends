BASE_URL = "http://www.omdbapi.com/?t="  
API_PARTIAL_URL = "#{ENV['OMDB_API_KEY']}" 

class OmdbService 

    attr_reader :results

    def get_movies_by_title_fragment(str)
        omd_api_key = API_PARTIAL_URL
        request = "http://www.omdbapi.com/?apikey=#{omd_api_key}&s=#{str}"
        result = handle_errors(HTTParty.get("#{request}"))
        #binding.pry
        return result
    end
    
    def get_movie_by_title(title)
        omd_api_key = API_PARTIAL_URL
        request = "http://www.omdbapi.com/?apikey=#{omd_api_key}&t=#{title}"
        result = handle_errors(HTTParty.get("#{request}"))
        return result
    end

    def get_movie_by_id(id)
        omd_api_key = API_PARTIAL_URL
        request = "http://www.omdbapi.com/?apikey=#{omd_api_key}&i=#{id}"
        result = handle_errors(HTTParty.get("#{request}"))
        return result
    end
    
    def handle_errors(response)
        if response.code == 200..299
          # successful request
          return response.parsed_response
        else
          return response.code.to_s
        end
    end
end
