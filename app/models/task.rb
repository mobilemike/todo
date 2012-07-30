class Task < ActiveRecord::Base
  attr_accessible :title
  
  validates :title, presence: true
  validates :title, uniqueness: true
end
