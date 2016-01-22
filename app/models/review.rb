class Review < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  has_many :endorsements
  validates :rating, inclusion: (1..5)
  validates :user,  uniqueness: { scope: :restaurant,
                    message: "Has reviewed this restaurant already"}
end
