class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  belongs_to :category

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :category, presence: true
  validates :image, presence: true
  validates :imageable, presence: true

  scope :order_by_created_at, (->{order created_at: :desc})
  scope :images_feed, (->user do
    where imageable_id: user.following_ids << user.id,
      imageable_type: User.name
  end)

  mount_uploader :image, ImageUploader

  def user
    imageable_is_users? ? imageable : imageable.user
  end

  def group
    imageable.group if imageable_is_group_users?
  end

  def object
    imageable_is_group_users? ? imageable.group : imageable
  end

  def categories
    Category.all
  end

  class << self
    def bookmarked_images user
      Image.where(id: user.bookmarks.pluck(:likeable_id)).order id: :desc
    end
  end

  private
  Settings.classes.each do |subj|
    define_method("imageable_is_#{subj.tableize}?") do
      imageable.class.name == subj.constantize.name
    end
  end
end
