class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :image

  has_many :likes, as: :likeable, dependent: :destroy

  validates :user, presence: true
  validates :image, presence: true
  validates :content, presence: true

  acts_as_tree order: "created_at DESC", dependent: :destroy

  def parent
    if self.present? && self.parent_id.present?
      Comment.find_by id: self.parent_id
    else
      self
    end
  end
end
