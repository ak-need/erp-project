class KitchenBillingsController < ApplicationController

  def get_billing_form

  end

  def append_items
    result = {}
    if params[:category].present?
      @items = Kitchen.where(category: params[:category])
      if @items.present?
        @items.each do |item|
          result[item.id] = item.item_name
        end
      end
    end
    respond_to do |format|
      format.json { render json: result.to_json }
    end
  end

  def fetch_item_detail
    result = []
    if params[:item_id].present? && params[:item_id].to_i != 0
      kitchen = Kitchen.find_by(id: params[:item_id].to_i)
      result << kitchen.id << kitchen.item_name << kitchen.price.to_f
    end
    respond_to do |format|
      format.json { render json: result.to_json }
    end
  end

end
