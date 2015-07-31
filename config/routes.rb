Rails.application.routes.draw do
  get 'users/show'

  root 'items#index'

  resources :photos

  resources :list_items
  get '/list_items/check_off/:id' => 'list_items#check_off', :as => "list_items_check_off"

  resources :items do
    get :autocomplete_food_name, :on => :collection
    get 'use', on: :member
    get 'dispose', on: :member
    get 'donate', on: :member
    get 'donated', on: :collection
  end

  resources :recipes
  get '/items/new/search/:foods' => 'items#new'

  resources :foodbanks do
    get 'find', on: :collection
  end

  get '/sms' => 'sms#receiving'

  get '/scan' => 'scans#scan', :as => "scan"

  devise_for :users
  get "/profile/:id" => 'users#show', :as => "profile"

  get "/points/:name" => 'users#points'

  get "/page/:name" => "pages#show"

end
