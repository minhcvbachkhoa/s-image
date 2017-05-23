class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  belongs_to :category

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :category, presence: true
  validates :image, presence: true
  validates :imageable, presence: true
end
