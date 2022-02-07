class BillingsController < ApplicationController

  def get_billing_form

  end

  def billing_for_product
    product_details = JSON.parse params[:product_details]
    if product_details && product_details[0].present?
      ActiveRecord::Base.transaction do
        product_details.each do |product_detail|
          product = Product.find product_detail['product_id']
          tax_percentage = product_details[0]["tax"].to_f
          price = product_details[0]["price"].to_f
          sold_quantity = product_detail["quantity"].to_i
          tax_amount = (price * tax_percentage/100) * sold_quantity
          sold_amount = sold_quantity * price
          vendor_amount = sold_amount - tax_amount
          SoldProduct.create(quantity: sold_quantity, sold_amount: sold_amount, product_id: product.id, vendor_id: product.vendor_id, tax_percentage: tax_percentage, vendor_amount: vendor_amount, tax_amount: tax_amount)
          VendorAmount.create(quantity: sold_quantity, sold_amount: sold_amount, product_id: product.id, vendor_id: product.vendor_id, tax_percentage: tax_percentage, vendor_amount: vendor_amount, tax_amount: tax_amount)
          rest_quantity = product.quantity - sold_quantity
          product.update_attributes(quantity: rest_quantity)
          flash[:success] = "product deplicated successfully!"
        end
      end
    end
    redirect_to billing_path
  end
end

