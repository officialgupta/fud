class ListItemsController < ApplicationController
  before_action :set_list_item, only: [:check_off]

  def index
    @list_items = current_user.list_items
  end

  def new
    @ilist_tem = ListItem.new
  end

  def create
    @list_item = ListItem.new(list_item_params)
    @list_item.user = current_user
    @list_item.food_id = Food.where(['lower(name) LIKE ?', "%#{params[:list_item][:food_id]}%"]).first.id
    respond_to do |format|
      if  @list_item.save
        format.html { redirect_to list_items_path, notice: 'Item was successfully added.' }
      else
        format.html { redirect_to list_items_path, alert: 'Please fill in the form correctly.' }
      end
    end
  end

  def check_off
    @list_item.check_off
    redirect_to list_items_path
  end

  def destroy
    @food_item.destroy
    redirect_to list_items_path, notice: 'Item was successfully destroyed.'
  end

  private

  def set_list_item
    @list_item = ListItem.find(params[:id])
  end


  def list_item_params
    params.require(:list_item).permit(:quantity, :quantity_type, :when_bought, :food_id)
  end
end
