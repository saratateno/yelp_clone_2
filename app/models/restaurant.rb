class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates :name, length: { minimum: 3 }, uniqueness: true


    def build_review(review_params, current_user)
      new_review = self.reviews.create(review_params)
      current_user.reviews << new_review
      return new_review
    end
end
