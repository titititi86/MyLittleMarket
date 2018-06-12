Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

get 'home/index'
root 'home#index'

get 'signup' => 'users#new'
get 'login'  => 'sessions#new'
post 'login' => 'sessions#create'
delete 'logout' => 'sessions#destroy'

resources :users
resources :products
resources :categories
resources :sales
resources :contacts
resources :subscribers

get 'subscribers/index'
get 'subscribers/all' => 'subscribers#all_subscribers'

end
