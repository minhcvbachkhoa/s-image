class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :image

  has_many :likes, as: :likeable, dependent: :destroy

  validates :user, presence: true
  validates :image, presence: true
  validates :content, presence: true

  scope :show_more_comment, (->offset do
    where("id < ?", offset).limit Settings.load_more_comment_size
  end)
end
