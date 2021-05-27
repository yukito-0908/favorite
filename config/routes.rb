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
   resources :posts, only: [:index,:create,:show]
  end
    resources :tags do
    get 'posts', to: 'posts#search'
  end

end

  devise_for :admins
end
