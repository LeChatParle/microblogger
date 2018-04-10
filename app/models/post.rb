class Post < ApplicationRecord
  #This creates the relationship between posts and comments
  #dependent/destroy force deletion of comments on deletion of post
  has_many :comments, dependent: :destroy

  #verifies that a title & body exists and that it is at least X length
  validates :title, presence: true, length: { minimum: 1 }
  validates :body, presence: true
end
