class Post < ApplicationRecord
  validates_presence_of :title
  belongs_to :user
  belongs_to :category
end
