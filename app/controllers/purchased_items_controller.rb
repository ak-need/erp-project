class PurchasedItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :load_item, only: [:show, :edit, :update, :destroy]

  def index
    @ourchased_items = PurchasedItem.all
  end

  def new
    @ourchased_item = PurchasedItem.new
  end

  def edit

  end

  def create
    @ourchased_item = PurchasedItem.new(purchased_item_params)
    if @ourchased_item.save
      flash[:success] = "Item created successfully!"
      redirect_to purchased_items_path
    else
      flash[:danger_messages] = @ourchased_item.errors.full_messages
      render :new
    end
  end

  def update
    if @ourchased_item.update(purchased_item_params)
      flash[:success] = "Item updated successfully!"
      redirect_to purchased_items_path
    else
      flash[:danger_messages] = @ourchased_item.errors.full_messages
      render :edit
    end
  end

  def destroy
    @ourchased_item.destroy
    flash[:success] = "Item deleted successfully!"
    redirect_to purchased_items_path
  end

  def excel_upload
    @co_header = "Excel Upload"
  end

  def import_items
    if PurchasedItem.import_product(params[:file])
      flash[:success] = "Product Uploaded Successfully!"
      redirect_to purchased_items_path
    else
      flash[:danger] = "Invalid Template!"
      redirect_to excel_upload_purchased_items_path
    end
  end

  def fetch_product_detail
    result = []
    if params[:product_id].present? && params[:product_id].to_i != 0
      product = PurchasedItem.find_by(id: params[:product_id].to_i)
      result << product.id << product.item_name << product.item_price << product.quantity
    end
    respond_to do |format|
      format.json { render json: result.to_json }
    end
  end

  def fetch_barcode_detail
    result = []
    product = PurchasedItem.where(item_barcode: params[:barcode]).first
    result << product.id << product.item_name << "Rs.#{sprintf "%.2f", product.item_price.to_f}" << product.quantity if product.present?
    respond_to do |format|
      format.json { render json: result.to_json }
    end
  end

  def billing_for_product

  end

  private

  def load_item
      @ourchased_item = PurchasedItem.find(params[:id])
    end

  def purchased_item_params
    params.require(:purchased_item).permit(:item_name, :item_price, :item_barcode, :purchased_from, :quantity, :category, :mode_of_payment)
  end

end
