class KitchensController < ApplicationController
  before_action :authenticate_admin!
  before_action :load_kitchen, only: [:update, :destroy, :edit]
  def index
    @co_header = "Lara's Kitchen"
    @kitchen_items = Kitchen.all
  end

  def new
    @co_header = "New Menu"
    @kitchen = Kitchen.new
  end

  def show

  end

  def edit
    @co_header = "Update Menu"
  end

  def create
    @kitchen = Kitchen.new(kitchen_params)
    if @kitchen.save
      flash[:success] = "Menu created succesfully"
      redirect_to kitchens_path
    else
      flash[:danger_messages] = @kitchen.errors.full_messages
      render :new
    end
  end

  def update
    if @kitchen.update(kitchen_params)
      flash[:success] = "Menu updated succesfully"
      redirect_to kitchens_path
    else
      flash[:danger_messages] = @kitchen.errors.full_messages
      render :edit
    end
  end

  def destroy
    @kitchen.destroy
    flash[:success] = "Menu deleted succesfully"
    redirect_to kitchens_path
  end
  def fetch_menu_category_wise
    if params[:category] == "chatt"
      @co_header = "Chatt Items"
      @menu_items = Kitchen.where(category: "CHATT")

    elsif params[:category] == "breakfast"
      @co_header = "Breakfast Items"
      @menu_items = Kitchen.where(category: "BREAKFAST")

    elsif params[:category] == "south_indian"
      @co_header = "South Indian Items"
      @menu_items = Kitchen.where(category: "SOUTH INDIAN")

    elsif params[:category] == "indian_bread"
      @co_header = "Indian Bread Items"
      @menu_items = Kitchen.where(category: "INDIAN BREAD")

    elsif params[:category] == "rice_item"
      @co_header = "Rice Items"
      @menu_items = Kitchen.where(category: "RICE ITEMS")

    elsif params[:category] == "chinese"
      @co_header = "Chinese Items"
      @menu_items = Kitchen.where(category: "CHINESE")

    elsif params[:category] == "meals"
      @co_header = "Meals"
      @menu_items = Kitchen.where(category: "MEALS")

    elsif params[:category] == "snacks"
      @co_header = "Snack Items"
      @menu_items = Kitchen.where(category: "SNACKS")

    elsif params[:category] == "drinks"
      @co_header = "Drink Items"
      @menu_items = Kitchen.where(category: "DRINKS")
    else
      @co_header = "Other Items"
      @menu_items = Kitchen.where(category: "OTHER")
    end
  end

  private


  def load_kitchen
    @kitchen = Kitchen.find_by(id: params[:id])
  end

  def kitchen_params
    params.require(:kitchen).permit(:item_name, :price, :category)
  end

end
