class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :review, :rating, presence: true
  validates :rating, length: {in: 1..5}
end
