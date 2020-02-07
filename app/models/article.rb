class Article < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :title, presence: true,
            length: {minimum: 2, maximum: 150}
  validates :text, presence: true,
            length: {minimum: 2, maximum: 256 }
end
