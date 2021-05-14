class Review < ApplicationRecord

    belongs_to :user
    belongs_to :movie
    
    validates :content, presence: true

    validates :movie, uniqueness: {scope: :user_id, message: "may only have one review per user"}
    
    def self.by_user(user_id)
        where(user: user_id)
    end
end
