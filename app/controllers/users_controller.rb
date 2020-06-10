class UsersController < ApplicationController
	before_action :baria_user, only: [:update]
  before_action :authenticate_user!, only: [:index, :show, :edit, :new ]

  def show
  	@user = User.find(params[:id])
    @books = @user.books.order(created_at: :desc)
    @book = Book.new

    @currentUserEntry = UserRoom.where(user_id: current_user.id)
    @userEntry = UserRoom.where(user_id: @user.id)
   

    unless @user.id == current_user.id

      @currentUserEntry.each do |cu|
        @userEntry.each do |u|

          if cu.room_id == u.room_id then
            
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = UserRoom.new
      end
    end  	
  end

  def index
  	 #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）    
    @books = Book.all
  end


  def edit
  	@user = User.find(params[:id])
    if @user.id != current_user.id
       flash[:notice] = "can't successfully access!"
      redirect_to user_path(current_user.id)
    end

  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to "/users/#{current_user.id}", notice: "successfully updated user!"
  	else
      flash[:notice] = "errors"
  		render :edit
  	end
  end
  def follower
    @user = User.find(params[:id])
  end
  def following
    @user = User.find(params[:id])
  end





  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image, :postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end

  #url直接防止 メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
   end
   def search_params
    params.require(:q).permit(:name_cont)
  end


end
