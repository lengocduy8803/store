class User < ApplicationRecord

  has_many :notifications, dependent: :destroy


  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
