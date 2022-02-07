class VendorAmount < ApplicationRecord
  belongs_to :product
  belongs_to :vendor
end
