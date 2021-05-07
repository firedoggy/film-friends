class User < ApplicationRecord
    
    has_many :friendships, dependent: :destroy  
    has_many :friends, through: :friendships
    has_many :reviews
    has_many :movies, through: :reviews

end
