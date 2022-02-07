class PurchasedItem < ApplicationRecord

  def self.import_product(file)
    temp_sheet = open_spreadsheet(file)
    return false if temp_sheet == false
    spreadsheet = temp_sheet.sheet('Purchased Items') rescue nil
    return false if spreadsheet == nil
    result = insert_data_to_database spreadsheet
    return false unless result.present?
    PurchasedItem.import result
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
    @purchased_items = []
    spreadsheet.each.with_index do |sheet, index|
      skip = [1,2,3]
      next if skip.include? index
      next if sheet[1] == "" || sheet[2] == "" || sheet[3] == "" || sheet[5] == "" || sheet[6] == "" || sheet[7] == "" || sheet[1] == nil || sheet[3] == nil || sheet[3] == nil || sheet[5] == nil || sheet[6] == nil || sheet[7] == nil
      @purchased_items << PurchasedItem.new(item_name: sheet[1], item_price: sheet[2], item_barcode: sheet[4], purchased_from: sheet[7], quantity: sheet[3], category: sheet[5], mode_of_payment: sheet[6])
    end
    @purchased_items
  end

end
