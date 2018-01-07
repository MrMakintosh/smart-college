class Group < ActiveRecord::Base
  belongs_to :specialty
  has_many :students
end
