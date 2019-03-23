class Book < ApplicationRecord
  belongs_to :author
  belongs_to :user

  has_many :reviews, dependent: :destroy
  has_many :users_review, through: :reviews, source: :user

  validates :title, presence: true, length: {minimum: 2}
end
