class PurchasedSaleReportsController < ApplicationController
  def index
    if params[:name].present? && params[:category].present?
      @purchased_sales_item = PurchasedSoldItem.where(name: params[:name], category: params[:category])
    elsif params[:name].present?
      @purchased_sales_item = PurchasedSoldItem.where(name: params[:name])
    elsif params[:category].present?
      @purchased_sales_item = PurchasedSoldItem.where(category: params[:category])
    else
      @purchased_sales_item = PurchasedSoldItem.all
    end
    if params[:format] == "pdf"
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Purchased Sale Report",
          page_size: 'A4',
          template: "purchased_sale_reports/purchased_sale_report.pdf.erb",
          orientation: "Landscape",
          layout: "purchased_sale_report_pdf.html.erb",
          lowquality: true,
          zoom: 1,
          dpi: 65,
          footer: { html: { template: "purchased_sale_reports/footer.pdf.erb" } },
          header: { html: { template: "purchased_sale_reports/header.pdf.erb" } }
        end
      end
    end
  end
end
