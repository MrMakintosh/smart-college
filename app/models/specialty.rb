class Specialty < ActiveRecord::Base
  belongs_to :department
  has_many :groups
end
