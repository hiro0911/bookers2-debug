class BookComments < ActiveRecord::Migration[5.2]
  def change
  	add_column :book_comments, :book_id, :integer
  	remove_column :book_comments, :post_image_id, :integer 
  end
end