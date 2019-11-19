Rails.application.routes.draw do
  get 'paths/create'
  get 'paths/new'
  get 'paths/show'
  get 'paths/update'
  get 'paths/destroy'
  get 'courses/index'
  get 'courses/show'
  get 'courses/new'
  get 'courses/create'
  get 'courses/destroy'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
end
