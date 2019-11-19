Rails.application.routes.draw do
  get 'courses/index'
  get 'courses/show'
  get 'courses/new'
  get 'courses/create'
  get 'courses/destroy'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users






  get 'users_courses/index'
  get 'users_courses/update'
  get 'users_courses/destroy'
end
