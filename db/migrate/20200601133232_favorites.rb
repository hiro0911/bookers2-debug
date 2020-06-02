class Favorites < ActiveRecord::Migration[5.2]
  def change
  	add_column :Favorites, :book_id, :integer
  	remove_column :Favorites, :post_image_id, :integer

  end
end
