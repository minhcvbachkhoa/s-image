class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :image

  has_many :likes, as: :likeable, dependent: :destroy

  validates :user, presence: true
  validates :image, presence: true
  validates :content, presence: true
end
