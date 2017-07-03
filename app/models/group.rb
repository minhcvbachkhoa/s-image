class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, dependent: :destroy
  has_many :images, through: :group_users, dependent: :destroy
  has_many :admin_groups, ->{where admin_group: true},
    class_name: GroupUser.name
  has_many :admins, through: :admin_groups, class_name: User.name, source: :user

  validates :name, presence: true

  enum policy: [:is_public, :is_private]

  mount_uploader :cover, ImageUploader

  def have_member? user
    users.include? user
  end

  def add_users params
    ids = params[:ids]
    current_user = params[:current_user]
    ActiveRecord::Base.transaction do
      ids.each do |id|
        user = User.find_by id: id.to_i
        self.group_users.create! user: user
        notification = Notification.create! owner: current_user,
          recipient: user, group: self
        if current_user == user
          group.admin_groups.each do |admin_group|
            NotificationJob.perform_now channel:
              "#{admin_group.email}_notification_channel",
              notification: notification, owner: current_user, recipient: user,
              group: self
          end
        else
          NotificationJob.perform_now channel:
            "#{user.email}_notification_channel", notification: notification,
            owner: current_user, recipient: user, group: self
        end
      end
    end
    return true
    rescue => e
    return false
  end
end
