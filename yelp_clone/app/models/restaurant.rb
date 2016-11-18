class Restaurant < ActiveRecord::Base

  belongs_to :user
  validates :name, length: { minimum: 3 }, uniqueness: true
  has_many :reviews,
      -> {extending WithUserAssociationExtension },
      dependent: :destroy

end
