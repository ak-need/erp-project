class PurchasedItemReportsController < ApplicationController
  def index
    if params[:purchased_from].present? && params[:mode_of_payment].present? && params[:category].present?
      @purchased_items = PurchasedItem.where(purchased_from: params[:purchased_from], mode_of_payment: params[:mode_of_payment], category: params[:category])
    elsif params[:purchased_from].present? && params[:mode_of_payment].present?
      @purchased_items = PurchasedItem.where(purchased_from: params[:purchased_from], mode_of_payment: params[:mode_of_payment])
    elsif params[:mode_of_payment].present? && params[:category].present?
      @purchased_items = PurchasedItem.where(mode_of_payment: params[:mode_of_payment], category: params[:category])
    elsif params[:purchased_from].present? && params[:category].present?
      @purchased_items = PurchasedItem.where(purchased_from: params[:purchased_from], category: params[:category])
    elsif params[:purchased_from].present?
      @purchased_items = PurchasedItem.where(purchased_from: params[:purchased_from])
    elsif params[:mode_of_payment].present?
      @purchased_items = PurchasedItem.where(mode_of_payment: params[:mode_of_payment])
    elsif params[:category].present?
      @purchased_items = PurchasedItem.where(category: params[:category])
    else
      @purchased_items = PurchasedItem.all
    end

    if params[:format] == "pdf"
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Purchased Item Report",
          page_size: 'A4',
          template: "purchased_item_reports/purchased_item_report.pdf.erb",
          orientation: "Landscape",
          layout: "purchased_item_report_pdf.html.erb",
          lowquality: true,
          zoom: 1,
          dpi: 65,
          footer: { html: { template: "purchased_item_reports/footer.pdf.erb" } },
          header: { html: { template: "purchased_item_reports/header.pdf.erb" } }
        end
      end
    end
  end
end
