class Notification < ApplicationRecord
  belongs_to :recipient, class_name: User.name
  belongs_to :owner, class_name: User.name
  belongs_to :group

  validates :recipient, presence: true
  validates :owner, presence: true
  validates :group, presence: true
end
