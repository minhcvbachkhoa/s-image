class Group < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :name, presence: true

  enum policy: [:is_public, :is_private]
end
