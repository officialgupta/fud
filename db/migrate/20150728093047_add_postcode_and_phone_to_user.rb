class AddPostcodeAndPhoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :postcode, :string
    add_column :users, :phone, :string
  end
end
