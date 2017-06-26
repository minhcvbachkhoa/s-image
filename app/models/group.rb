class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, dependent: :destroy
  has_many :images, through: :group_users, dependent: :destroy
  has_many :admin_groups, ->{where admin_group: true},
    class_name: GroupUser.name
  has_many :admins, through: :admin_groups, class_name: User.name, source: :user

  validates :name, presence: true

  enum policy: [:is_public, :is_private]

  def have_member? user
    users.include? user
  end
end
