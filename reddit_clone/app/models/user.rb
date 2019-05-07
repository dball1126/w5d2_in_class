# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    validates :password_digest, :session_token, :username, presence: true, uniqueness: true
    validates :password, length: {minimum: 6, allow_nil: true}

    attr_reader :password

    has_many :subs

    has_many :posts

    after_initialize :ensure_token

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            return user
        else 
            return nil
        end
    end
    
    def self.generate_token
        return SecureRandom.urlsafe_base64
    end

    def is_password?(password)
        check = BCrypt::Password.new(self.password_digest)
        return check.is_password?(password) 
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def reset_token!
        self.session_token = User.generate_token
        self.save!
        return self.session_token
    end

    def ensure_token
        self.session_token ||= User.generate_token
    end
end
