class Vendor < ApplicationRecord
  validates :name, presence: { message: "Cant be Blanck" }
  has_many :products, dependent: :destroy
end
