class Product < ApplicationRecord
  require 'roo'

  belongs_to :vendor
  validates :vendor_id, presence: { message: "Vendor must be presence" }

  def self.import_product(file)
    temp_sheet = open_spreadsheet(file)
    return false if temp_sheet == false
    spreadsheet = temp_sheet.sheet('Products') rescue nil
    return false if spreadsheet == nil
    result = insert_data_to_database spreadsheet
    Product.import result if result.present?
    true
  end

  def self.open_spreadsheet file
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else return false
    end
  end

  def self.insert_data_to_database spreadsheet
    @product = []
    spreadsheet.each.with_index do |sheet, index|
      next if index == 0
      next if sheet[2] == "" || sheet[3] == "" || sheet[4] == "" || sheet[6] == "" || sheet[7] == "" || sheet[8] == "" || sheet[2] == nil || sheet[3] == nil || sheet[4] == nil || sheet[6] == nil || sheet[7] == nil || sheet[8] == nil
      vendor_detail = Vendor.find_by(name: sheet[3])
      vendor_id = vendor_detail.id if vendor_detail.present?
      @product << Product.new( sku_no: sheet[1], name: sheet[2], category: sheet[4], barcode: sheet[5], quantity: sheet[6], base_price: sheet[7], sale_price: sheet[8], gst_percentage: sheet[8], cost: sheet[10], hsn_code: sheet[11], vendor_id: vendor_id )
    end
    @product
  end

end

