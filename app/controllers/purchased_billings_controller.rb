class PurchasedBillingsController < ApplicationController

  def get_billing_form

  end

  def billing_for_product
    product_details = JSON.parse params[:product_details]
    if product_details && product_details[0].present?
      total_sold_amount = 0
      ActiveRecord::Base.transaction do
        product_details.each do |product_detail|
          total_sold_amount = total_sold_amount + product_detail["sub_total"].to_f
          sold_quantity = product_detail["quantity"].to_i
          sold_amount = product_detail["sub_total"].to_f
          product = PurchasedItem.find product_detail['product_id']
          PurchasedSoldItem.create(name: product.item_name, price: product.item_price, quantity: sold_quantity, barcode: product.item_barcode, category: product.category, total_value: sold_amount)
          rest_quantity = product.quantity - sold_quantity
          product.update_attributes(quantity: rest_quantity)
          flash[:success] = "product deplicated successfully!"
        end
        redirect_to purchased_billing_path
      end
    end
  end
end
