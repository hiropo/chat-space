class Group < ApplicationRecord
  validates :name, presence: true

  has_many :members
  has_many :messages
  has_many :users, through: :members
end