class Album < ApplicationRecord
  belongs_to :user

  has_many :images, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :images

  validates :name, presence: true
end
