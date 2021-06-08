Rails.application.routes.draw do

  root :to => 'public/homes#top'

devise_for :users, controllers: {
  sessions: 'user/sessions',
  registrations: 'user/registrations'
}

namespace :public, path: "" do
    resources :notifications, only: :index
    get 'users/mypage/:id' => 'users#mypage'
    resources :users, only: [:edit, :update ,:index , :show] do
    resources :posts, only: [:index,:create,:show,:edit,:update, :destroy] do
    delete 'post_item_destroy'
    post 'post_item_create'
    resources :post_items, only: [:destroy, :index]
    resources :likes, only: [:create, :destroy, :index]
    resources :comments, only: [:create, :destroy]
  end
   get 'users/tags' => 'posts#post_tags'
    get 'search_posts', to: 'posts#search'
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    resource :favorites, only: [:create, :destroy]
  end
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show, :index]
  get '/profiles/mypage' => 'profiles#mypage'
  end
  devise_for :admins
end
