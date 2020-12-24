class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 50 },format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, presence: true
  validates :profile, length: { maximum: 160 }
  has_secure_password
  
  mount_uploader :image, ImageUploader
end
