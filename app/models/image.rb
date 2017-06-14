class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  belongs_to :category

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :category, presence: true
  validates :image, presence: true
  validates :imageable, presence: true

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

  private
  Settings.classes.each do |subj|
    define_method("imageable_is_#{subj.tableize}?") do
      imageable.class.name == subj.constantize.name
    end
  end
end
