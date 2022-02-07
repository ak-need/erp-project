class ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :load_product, only: [:show, :edit, :update, :destroy]

  def index
    @vendors = Vendor.all
    @products = Product.all
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="sample_products.xlsx"'
      }
    end
  end

  def show

  end

  def new
    @co_header = "New Product"
    @product = Product.new
  end

  def edit
    @co_header = "Edit Product"
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Product Created Successfully!"
      redirect_to fetch_product_vendor_wise_products_path(vendor_id: @product.vendor_id)
    else
      flash[:danger_messages] = @product.errors.full_messages
      render :new
    end
  end

  def update
    if @product.update(product_params)
      flash[:success] = "Product Updated Successfully!"
      redirect_to fetch_product_vendor_wise_products_path(vendor_id: @product.vendor_id)
    else
      flash[:danger_messages] = @product.errors.full_messages
      render :edit
    end
  end

  def destroy
    @product.destroy
    flash[:success] = "Product Deleted Successfully!"
    redirect_to products_path
  end

  def fetch_product_vendor_wise
    @vendor_wise_products = Product.joins(:vendor).where(vendor_id: params[:vendor_id])
  end

  def excel_upload
    @co_header = "Excel Upload"
  end

  def import_products
    if Product.import_product(params[:file])
      flash[:success] = "Product Uploaded Successfully!"
      redirect_to products_path
    else
      flash[:danger] = "Invalid Template!"
      redirect_to excel_upload_products_path
    end
  end

  def append_product
    result = {}
    if params[:vendor_id] && params[:vendor_id].to_i != 0
      @products = Product.where(vendor_id: params[:vendor_id].to_i)
      if @products.present?
        @products.each do |product|
          result[product.id] = "#{product.name} - Rs.#{sprintf "%.2f", product.sale_price.to_f}"
        end
      end
    end
    respond_to do |format|
      format.json { render json: result.to_json }
    end
  end

  def append_vendor
    result = []
    if params[:vendor_id].present? && params[:vendor_id].to_i != 0
      vendor = Vendor.find_by(id: params[:vendor_id].to_i)
      result << vendor.name << vendor.mobile << vendor.gstin
    end
    respond_to do |format|
      format.json { render json: result.to_json }
    end
  end

  def fetch_product_detail
    result = []
    if params[:barcode].present? && params[:vendor_id].present?
      product = Product.where(barcode: params[:barcode], vendor_id: params[:vendor_id]).first
      result << product.id << product.name << product.sale_price.to_f << product.quantity << product.vendor.name if product.present?
    else
      product = Product.find_by(id: params[:product_id].to_i)
      if product.present?
        vendor_name = product.vendor.name
        result << product.id << product.name << product.sale_price.to_f << product.quantity << vendor_name
      end
    end
    respond_to do |format|
      format.json { render json: result.to_json }
    end
  end

  private

    def load_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :sku_no, :category, :barcode, :quantity, :base_price, :sale_price, :gst_percentage, :cost, :hsn_code, :vendor_id)
    end

end

