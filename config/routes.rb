Rails.application.routes.draw do

  root :to => 'public/homes#top'

devise_for :users, controllers: {
  sessions: 'user/sessions',
  registrations: 'user/registrations'
}

namespace :public, path: "" do
  resources :users, only: [:edit, :update ,:index , :show] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    resource :favorites, only: [:create, :destroy]
  end
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
  get '/profiles/mypage' => 'profiles#mypage'
  resources :profiles do
    resources :posts, only: [:index,:create,:show,:edit, :update, :destroy] do
      delete 'post_item_destroy'
      post 'post_item_create'
      resources :post_items, only: [:destroy]
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    get 'search_posts', to: 'posts#search'
  end
    resources :tags, only: [:show]
  end
  devise_for :admins
end
