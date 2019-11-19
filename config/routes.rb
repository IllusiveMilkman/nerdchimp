Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users

  resources :courses

  resources :paths

  get 'users_courses/index'
  get 'users_courses/update'
  get 'users_courses/destroy'

end
