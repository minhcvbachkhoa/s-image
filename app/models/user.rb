class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :albums, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :images, as: :imageable, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :active_notifications, class_name: Notification.name,
    foreign_key: "owner_id", dependent: :destroy
  has_many :passive_notifications, class_name: Notification.name,
    foreign_key: "recipient_id", dependent: :destroy

  validates :email, presence: true, length: {maximum: 255},
    format: {with: Devise.email_regexp}, uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    length: {within: Devise.password_length}, allow_nil: true
  validates :name, presence: true, length: {maximum: 50}

  enum admin: [:not_admin, :admin]

  mount_uploader :avatar, ImageUploader
  mount_uploader :cover, ImageUploader

  def is_admin_group? group
    group.admins.include? self
  end

  def current_user? user
    self == user
  end

  def followed? user
    following.include? user
  end

  def follow other_user
    following << other_user
    active_relationships.last
  end

  def unfollow other_user
    following.delete other_user
  end

  def user_relationship user
    active_relationships.find_by followed_id: user.id
  end

  def bookmarks
    likes.where likeable_type: "Bookmark"
  end

  def bookmark image
    bookmarks.where(likeable_id: image.id).first
  end

  def liked likeable
    likes.find_by likeable: likeable
  end

  def unread_notifications
    self.passive_notifications.where read: false
  end
end
