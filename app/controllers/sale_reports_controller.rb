class SaleReportsController < ApplicationController

  def index
    if params[:vendor_id].present? && params[:product_id].present? && params['date_range'].present?
      from_date, to_date = from_date_and_to_date params['date_range']
      @sold_products = SoldProduct.where(vendor_id: params[:vendor_id], product_id: params[:product_id], created_at: from_date..to_date).order('created_at desc')
    elsif params[:vendor_id].present? && params['date_range'].present?
      from_date, to_date = from_date_and_to_date params['date_range']
      @sold_products = SoldProduct.where(vendor_id: params[:vendor_id], created_at: from_date..to_date).order('created_at desc')
    elsif params[:product_id].present? && params['date_range'].present?
      from_date, to_date = from_date_and_to_date params['date_range']
      @sold_products = SoldProduct.where(product_id: params[:product_id], created_at: from_date..to_date).order('created_at desc')
    elsif params[:vendor_id].present? && params[:product_id].present?
      @sold_products = SoldProduct.where(vendor_id: params[:vendor_id], product_id: params[:product_id]).order('created_at desc')
    elsif params['date_range'].present?
      from_date, to_date = from_date_and_to_date params['date_range']
      @sold_products = SoldProduct.where(created_at: from_date..to_date).order('created_at desc')
    elsif params[:vendor_id].present?
      @sold_products = SoldProduct.where(vendor_id: params[:vendor_id]).order('created_at desc')
    elsif params[:product_id].present?
      @sold_products = SoldProduct.where(product_id: params[:product_id]).order('created_at desc')
    else
      @sold_products = SoldProduct.all.order('created_at desc')
    end
    if params[:format] == "pdf"
      @report_name = "Sale Report"
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

end
