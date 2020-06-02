class FavoritesController < ApplicationController
	def create
		@favorite = current_user.favorites.create(book_id: params[:book_id])
		@favorite.save
		if request.referer&.include?(book_path(id: params[:book_id]))
			redirect_to book_path(id: params[:book_id])
		else
			redirect_to books_path
		end
	end
	def destroy
		@favorite = Favorite.find_by(book_id: params[:book_id], user_id: current_user.id)
		@favorite.destroy
		if request.referer&.include?(book_path(id: params[:book_id]))
			redirect_to book_path(id: params[:book_id])
		else
			redirect_to books_path
		end
	end
end
#いいねを作成, いいねを削除した後は、行う前にいた画面に遷移すること