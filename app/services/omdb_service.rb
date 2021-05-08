BASE_URL = "http://www.omdbapi.com/?t="  
API_PARTIAL_URL = "&apikey=ee7fca41"#{ENV['OMDB_API_KEY']}" 

class OmdbService 

    attr_reader :results

    def self.search(search)
        @results = HTTParty.get(BASE_URL + "#{search}" + API_PARTIAL_URL)
        @results
    end
end