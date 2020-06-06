Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
   }

	resources :users
	resources :books do
		resource :favorites, only: [:create, :destroy]
		resources :book_comments, only: [:create, :destroy]
	end
	resources :relationships, only: [:create, :destroy]

	root 'home#top'
	get 'home/about' => 'home#about'
	post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  get 'users/follower/:id' => 'users#follower'
  get 'users/following/:id' => 'users#following'
  get 'search' => 'search#search'
end
