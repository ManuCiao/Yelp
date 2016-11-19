class Review < ActiveRecord::Base
  validates :rating, inclusion: (1..5)
end
