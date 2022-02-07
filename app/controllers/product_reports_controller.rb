class ProductReportsController < ApplicationController
  def index
    if params[:vendor_id].present? && params[:product_id].present? && params[:category].present?
      @products = Product.where(id: params[:product_id], vendor_id: params[:vendor_id], category: params[:category])
    elsif params[:vendor_id].present? && params[:category].present?
      @products = Product.where(vendor_id: params[:vendor_id], category: params[:category])
    elsif params[:product_id].present? && params[:category].present?
      @products = Product.where(product_id: params[:product_id], category: params[:category])
    elsif params[:vendor_id].present? && params[:product_id].present?
      @products = Product.where(vendor_id: params[:vendor_id], product_id: params[:product_id])
    elsif params[:category].present?
      @products = Product.where(category: params[:category])
    elsif params[:vendor_id].present?
      @products = Product.where(vendor_id: params[:vendor_id])
    elsif params[:product_id].present?
      @products = Product.where(product_id: params[:product_id])
    else
      @products = Product.all
    end
    if params[:format] == "pdf"
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Products Report",
          page_size: 'A4',
          template: "product_reports/products_report.pdf.erb",
          orientation: "Landscape",
          layout: "products_report_pdf.html.erb",
          lowquality: true,
          zoom: 1,
          dpi: 65,
          footer: { html: { template: "product_reports/footer.pdf.erb" } },
          header: { html: { template: "product_reports/header.pdf.erb" } }
        end
      end
    end
  end
end
