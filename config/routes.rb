Rails.application.routes.draw do

  root 'dash_boards#index'
  resources :vendors do
    collection do
      get 'fetch_vendor_amount'
      get 'delete_vendor_amount'
    end
  end
  resources :sale_reports, only: [:index, :destroy]
  resources :product_reports
  resources :vendor_reports
  resources :purchased_item_reports
  resources :purchased_sale_reports
  resources :purchased_items do
    collection do
      get 'excel_upload'
      post 'import_items'
      post 'get_barcode'
      get 'fetch_product_detail'
      get 'fetch_barcode_detail'
    end
  end
  resources :products do
    collection do
      get 'fetch_product_vendor_wise'
      get 'excel_upload'
      post 'import_products'
      get 'append_product'
      get 'append_vendor'
      get 'fetch_product_detail'
    end
  end
  get 'billing', to: 'billings#get_billing_form'
  get 'billing_for_kitchen', to: 'kitchen_billings#get_billing_form'
  get 'kitchen_billings/append_items', to: 'kitchen_billings#append_items'
  get 'kitchen_billings/fetch_item_detail', to: 'kitchen_billings#fetch_item_detail'
  post 'billings/billing_for_product', to: 'billings#billing_for_product'
  get 'purchased_billing', to: 'purchased_billings#get_billing_form'
  post 'purchased_billings/billing_for_product', to: 'purchased_billings#billing_for_product'
  devise_for :admins
  resources :kitchens do
    collection do
      get 'fetch_menu_category_wise'
    end
  end

end
