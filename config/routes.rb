Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :user_courses
    resources :paths do
      resources :users_courses_paths, only: [:create, :new]
    end
    resources :users_courses_paths, except: [:create, :new]
  end
  resources :courses

  post "/add_course", to:'user_courses#add_course'
end

