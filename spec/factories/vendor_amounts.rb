FactoryGirl.define do
  factory :vendor_amount do
    quantity 1
    sold_amount 1.5
    gst "MyString"
    tax_percentage 1.5
    vendor_amount 1.5
    tax_amount 1.5
    product nil
    vendor nil
  end
end
