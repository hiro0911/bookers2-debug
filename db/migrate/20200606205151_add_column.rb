class AddColumn < ActiveRecord::Migration[5.2]
  def change
  	remove_column :chats, :message, :text
  	add_column :chats, :content, :text
  end
end
