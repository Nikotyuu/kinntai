class Base < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true
  validates :attendance_sort, presence: true
end