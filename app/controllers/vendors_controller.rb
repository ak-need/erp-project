class VendorsController < ApplicationController
  before_action :authenticate_admin!
  before_action :load_vendor, only: [:edit, :update, :destroy]

  def index
    @co_header = "Listing Vendors"
    @vendors = Vendor.all
  end

  def new
    @co_header = "New Vendor"
    @vendor = Vendor.new
  end
  def create
    @vendor = Vendor.new(vendor_params)
    if @vendor.save
      flash[:success] = "Vendor Created Succussfully"
      redirect_to vendors_path
    else
      flash[:danger_messages] = @vendor.errors.full_messages
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @vendor.update(vendor_params)
      flash[:success] = "Vendor Updated Succussfully"
      redirect_to vendors_path
    else
      flash[:danger_messages] = @vendor.errors.full_messages
      render :edit
    end
  end

  def destroy
    @vendor.destroy
    flash[:success] = "Vendor Deleted Succussfully"
    redirect_to vendors_path
  end

  def fetch_vendor_amount
    if params[:vendor_id].present? && params[:product_id].present? && params['date_range'].present?
      from_date, to_date = from_date_and_to_date params['date_range']
      @vendor_amounts = VendorAmount.where(vendor_id: params[:vendor_id], product_id: params[:product_id], created_at: from_date..to_date).order('created_at desc')
    elsif params[:vendor_id].present? && params['date_range'].present?
      from_date, to_date = from_date_and_to_date params['date_range']
      @vendor_amounts = VendorAmount.where(vendor_id: params[:vendor_id], created_at: from_date..to_date).order('created_at desc')
    elsif params[:product_id].present? && params['date_range'].present?
      from_date, to_date = from_date_and_to_date params['date_range']
      @vendor_amounts = VendorAmount.where(product_id: params[:product_id], created_at: from_date..to_date).order('created_at desc')
    elsif params[:vendor_id].present? && params[:product_id].present?
      @vendor_amounts = VendorAmount.where(vendor_id: params[:vendor_id], product_id: params[:product_id]).order('created_at desc')
    elsif params['date_range'].present?
      from_date, to_date = from_date_and_to_date params['date_range']
      @vendor_amounts = VendorAmount.where(created_at: from_date..to_date).order('created_at desc')
    elsif params[:vendor_id].present?
      @vendor_amounts = VendorAmount.where(vendor_id: params[:vendor_id]).order('created_at desc')
    elsif params[:product_id].present?
      @vendor_amounts = VendorAmount.where(product_id: params[:product_id]).order('created_at desc')
    else
      @vendor_amounts = VendorAmount.all.order('created_at desc')
    end
    if params[:format] == "pdf"
      @report_name = "#{Vendor.find_by(id: params[:vendor_id]).name rescue nil} Amount Report"
      @check_condition_in_pdf = "Vendor Amount"
      @sold_products = @vendor_amounts
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Sales Report",
          page_size: 'A4',
          template: "sale_reports/sales_report.pdf.erb",
          orientation: "Landscape",
          layout: "sales_report_pdf.html.erb",
          lowquality: true,
          zoom: 1,
          dpi: 65,
          footer: { html: { template: "sale_reports/footer.pdf.erb" } },
          header: { html: { template: "sale_reports/header.pdf.erb" } }
        end
      end
    end
  end

  def from_date_and_to_date date_range
    to_date = date_range.split("-")[1].strip.to_date.end_of_day
    from_date = date_range.split("-")[0].strip.to_date.beginning_of_day
    [from_date, to_date]
  end

  def delete_vendor_amount
    vendor_amount_id = params[:vendor_amount_id].to_i
    amount_result = VendorAmount.find_by(id: vendor_amount_id)
    amount_result.destroy if amount_result.present?
    flash[:success] = "Vendor amount deleted successfully!"
    redirect_to fetch_vendor_amount_vendors_path(vendor_id: params[:vendor_id])
  end

  private

  def load_vendor
    @vendor = Vendor.find_by(id: params[:id])
  end

  def vendor_params
    params.require(:vendor).permit(:name, :email, :mobile, :gstin)
  end
end
