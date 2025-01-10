class User < ApplicationRecord

  has_many :notifications, dependent: :destroy


  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

    # Phương thức tạo token reset mật khẩu
    def generate_reset_password_token
      self.reset_password_token = SecureRandom.hex(10)
      save!
    end
    
end
