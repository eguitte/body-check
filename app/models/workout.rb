class Workout < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 250 }
  validates :title, presence: true, length: { maximum: 20 }
end
