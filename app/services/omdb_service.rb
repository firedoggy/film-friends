require 'omdb/api'

class OmdbService
    require 'pry'
    def initialize()
        api_key = ENV["OMDB_API_KEY"]

        raise "Missing Omdb api key. Remember to add OMDB_API_KEY to config/application.yml" if api_key.nil?

        @client = Omdb::Api::Client.new(api_key: api_key)
    end

    def self.find_by_title(params)
        binding.pry
        result = @client.find_by_title(params[:title], :type => 'movie')
    end
end