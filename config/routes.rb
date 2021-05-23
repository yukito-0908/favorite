Rails.application.routes.draw do

  devise_for :users
  root :to => 'public/homes#top'

  devise_for :admins

  namespace :public,  path: "" do
    get 'homes/top' => 'homes#top'
  end



end
