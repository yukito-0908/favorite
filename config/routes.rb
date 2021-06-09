Rails.application.routes.draw do

  root :to => 'public/homes#top'

devise_for :users, controllers: {
  sessions: 'user/sessions',
  registrations: 'user/registrations'
}

namespace :public, path: "" do
  get 'users/mypage' => 'users#mypage'
  get 'search_all' => 'users#search_all'
  post 'search_all' => 'users#search_all'
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
    post 'search_posts', to: 'posts#search'
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    resource :favorites, only: [:create, :destroy]
  end
  resources :messages, only: [:create, :destroy]
  resources :rooms, only: [:create,:show, :index]
  end
  devise_for :admins
end
