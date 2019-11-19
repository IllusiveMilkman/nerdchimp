Rails.application.routes.draw do
  get 'users_courses_paths/index'
  get 'users_courses_paths/create'
  get 'users_courses_paths/new'
  get 'users_courses_paths/edit'
  get 'users_courses_paths/update'
  get 'users_courses_paths/destroy'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :user_courses
  end

  resources :courses

  resources :paths


end
