class Movie < ApplicationRecord

    has_many :reviews
    has_many :users, through: :reviews

    validates :title, presence: true, length: { minimum: 1 }
    serialize :omdb_data
    validate :omdb_data_exists
    before_save :fetch_omdb_data

    def omdb(attribute)
        if self.omdb_data
            self.omdb_data[attribute]
        else
            ''
        end
    end

    def self.search(query)
        if query.blank?
            self.all
        else
          OmdbService.find_by_title(query)
        end
    end

    def omdb_data_exists
        movie = OmdbService.new.find_by_title({ title: self.title })

        if movie.is_a? Omdb::Api::Error
            errors.add(:title, 'could not be synced with data from OMDB')
        end
    end

    private

    def fetch_omdb_data
        movie = OmdbService.new.find_by_title({ title: self.title })

        if movie.is_a? Omdb::Api::Movie
            self.title = movie.title
            self.omdb_data = {
                "poster" => movie.poster,
                "actors" => movie.actors,
                "genre" => movie.genre,
                "runtime" => movie.runtime,
                "year" => movie.year,
                "director" => movie.director,
                "plot" => movie.plot,
                "imdb_rating" => movie.imdb_rating,
            }
        else
            self.omdb_data = nil
        end
    end

end
