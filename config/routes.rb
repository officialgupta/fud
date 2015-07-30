Rails.application.routes.draw do
  get 'users/show'

  root 'items#index'

  resources :photos

  resources :items do
    get :autocomplete_food_name, :on => :collection
    get 'use', on: :member
    get 'dispose', on: :member
    get 'donate', on: :member
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

  get ':name' => 'pages#show'

end
