class Album < ApplicationRecord
  belongs_to :user

  has_many :images, as: :imageable, dependent: :destroy

  validates :name, presence: true
end
