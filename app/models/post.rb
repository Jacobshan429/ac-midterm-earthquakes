class Post < ApplicationRecord
  validates_presence_of :title
  belongs_to :user
  belongs_to :category
  has_many :comments, :dependent => :destroy
end
