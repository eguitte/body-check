class Diary < ApplicationRecord
  belongs_to :user
  
  validates :weight, presence: true
  validates :height, presence: true
  mount_uploader :image, ImageUploader
  
  enum status: { public: 0, private: 1 }, _prefix: true
end
  
