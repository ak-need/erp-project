class VendorReportsController < ApplicationController
  def index
    @vendors = Vendor.all
    if params[:format] == "pdf"
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Vendors Report",
          page_size: 'A4',
          template: "vendor_reports/vendors_report.pdf.erb",
          orientation: "Landscape",
          layout: "vendors_report_pdf.html.erb",
          lowquality: true,
          zoom: 1,
          dpi: 65,
          footer: { html: { template: "vendor_reports/footer.pdf.erb" } },
          header: { html: { template: "vendor_reports/header.pdf.erb" } }
        end
      end
    end
  end
end
