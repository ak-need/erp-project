class DashBoardsController < ApplicationController
  def index
    @co_header = "Dashboard"
    @vendors = Vendor.all.order('created_at asc')
  end
end
