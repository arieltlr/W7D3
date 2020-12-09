class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password, length: {minimum: 6}, allow_nil: true
    validates :password_digest, presence: true

    after_initialize :ensure_session_token

    attr_reader :password

    #FIGVAPER
    def self.find_by_credentials(username, password)
        user = user.find_by(username: username)
        return nil unless user && user.is_password?(password)
        user
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end
    
    def reset_session_token!
        self.update!(session_token: self.generate_session_token)
        self.session_token

    end

    private
    def self.generate_session_token
        SecureRandom.urlsafe_base64(16)
    end

    def user_params
        params.require(:user).permit(:username, :password)
    end
    
    def ensure_session_token
        self.session_token ||= self.class.generate_session_token 
    end
    

end
