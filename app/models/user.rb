class User < ActiveRecord::Base
    validates_presence_of :name, :email
    validates_uniqueness_of :email, case_sensitive: false
    validates :password, length: {minimum: 6}
    
    has_many :microposts, dependent: :destroy
    
    has_many :relationships, foreign_key: :follower_id, dependent: :destroy
    has_many :followed_users, through: :relationships, source: :followed
    
    has_many :reverse_relationships, foreign_key: :followed_id, class_name: 'Relationship', dependent: :destroy
    has_many :followers, through: :reverse_relationships, source: :follower
    
    before_save { self.email = email.downcase }
    before_create :create_remember_token
    
    has_secure_password
    
    def User.new_remember_token
        SecureRandom.urlsafe_base64
    end
    
    def User.encrypt(token)
        Digest::SHA1.hexdigest(token.to_s)
    end
    
    def create_remember_token
        self.remember_token = User.encrypt(User.new_remember_token)
    end
    
    def feed
        Micropost.from_users_followed_by(self)
    end
  
    def following?(other_user)
        relationships.find_by_followed_id(other_user.id)
    end
  
    def follow!(other_user)
        relationships.create(followed_id: other_user.id)
    end
    
    def unfollow!(other_user)
        relationships.find_by_followed_id(other_user.id).destroy
    end

end
