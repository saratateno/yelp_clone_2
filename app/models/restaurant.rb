require_relative 'with_user_association_extension'

class Restaurant < ActiveRecord::Base
  has_many :reviews,
    -> { extending WithUserAssociationExtension },
    dependent: :destroy
  belongs_to :user
  validates :name, length: { minimum: 3 }, uniqueness: true

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating)
  end

end
