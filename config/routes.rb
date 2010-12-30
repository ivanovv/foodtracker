Demo::Application.routes.draw do |map|

  match "login", :to => "user_sessions#new"
  match "logout", :to => "user_sessions#destroy"
  resources :user_sessions, :only => [:new, :create, :destroy]

  resources :categories do
    resources :products
  end

  resources :days do
    resources :calory_lines
  end

  match 'products/get_energy' => 'products#get_energy'
  match 'products/get_utkonos_link' => 'products#get_utkonos_link'
  resources :calory_lines, :users, :products

  root :to => "products#index"

end

