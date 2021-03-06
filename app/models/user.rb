class User < ApplicationRecord
    
    has_many :friendships, dependent: :destroy  
    has_many :friends, through: :friendships
    has_many :reviews
    has_many :movies, -> { distinct }, through: :reviews
    
    validates :email, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
    validates :first_name, presence: true
    validates :last_name, presence: true
    has_secure_password

    def to_s
        return self.first_name + " " + self.last_name
    end

    def self.most_active
        joins(:reviews).group(:user_id).order("count(user_id) DESC").limit(3)
    end

    def self.from_omniauth(response)
        User.find_or_create_by(uid: response[:uid], provider: response[:provider]) do |u|
            u.first_name = response[:info][:first_name]
            u.last_name = response[:info][:last_name]
            u.email = response[:info][:email]
            u.password = SecureRandom.hex(15)
        end
    end

end