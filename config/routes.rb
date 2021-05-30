Rails.application.routes.draw do

  root :to => 'public/homes#top'

devise_for :users, controllers: {
  sessions: 'user/sessions',
  registrations: 'user/registrations'
}

namespace :public, path: "" do
  resources :users, only: [:edit, :update]
  get '/profiles/mypage' => 'profiles#mypage'
  resources :profiles do
    resources :posts, only: [:index,:create,:show,:edit] do
      post 'post_item_create'
    end
    get 'search_posts', to: 'posts#search'
  end
    resources :tags do
  end

end

  devise_for :admins
end
