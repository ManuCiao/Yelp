class Restaurant < ActiveRecord::Base
    belongs_to :user
    validates :name, length: { minimum: 3 }, uniqueness: true
    has_many :reviews,
             -> { extending WithUserAssociationExtension },
             dependent: :destroy

    def average_rating
        return 'N/A' if reviews.none?
        # reviews.inject(0) { |memo, review| memo + review.rating } / reviews.count
        reviews.average(:rating)
  end
end
