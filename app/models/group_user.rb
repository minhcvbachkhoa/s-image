class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  has_many :images, as: :imageable, dependent: :destroy

  validates :group, presence: true
  validates :user, presence: true
end
