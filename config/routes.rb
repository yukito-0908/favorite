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
    resources :posts, only: [:index,:create]
  end

end

  devise_for :admins
end
