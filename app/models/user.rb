class User < ApplicationRecord
  has_secure_password
  has_many :books, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :reviewed_books, through: :reviews, source: :book

  validates :username, :email, presence: true
  validates :username, length: {minimum: 2}
  validates :password, presence: {on: :create}, length: {minimum: 8}
  validates :email, uniqueness: {on: :create}, 
          format: {with: URI::MailTo::EMAIL_REGEXP, message: "only allows valid emails"}

  before_save :lowercase_email

  def lowercase_email
    self.email.downcase!
  end
end
