FactoryGirl.define do
  factory :sold_product do
    quantity 1
    sold_amount 1.5
    gst "MyString"
    sale nil
  end
end
