class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  autocomplete :food, :name

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    if params[:foods].present?
    @foods = Food.search(params[:foods])
    else
      @foods = Food.all
    end
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.user = current_user
    @item.food_id = Food.where(:name => params[:item][:food_id]).first.id
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully added.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def donate
    @item = Item.find(params[:id])
    @item.status = "donating"
    @item.save

    redirect_to items_url
  end

  def dispose
    @item = Item.find(params[:id])
    @item.status = "disposed"
    @item.save

    redirect_to items_url
  end

  def use
    @item = Item.find(params[:id])
    @item.status = "used"
    @item.save

    redirect_to items_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:quantity, :quantity_type, :when_bought, :food_id)
    end
end
