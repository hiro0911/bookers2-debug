class RelationshipsController < ApplicationController
  
  def follow
    current_user.follow(params[:id])
    path = Rails.application.routes.recognize_path(request.referer)
    redirect_to path
  end

  def unfollow
    current_user.unfollow(params[:id])
    path = Rails.application.routes.recognize_path(request.referer)
    redirect_to path
  end

  
end