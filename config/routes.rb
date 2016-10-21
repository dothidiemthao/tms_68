Rails.application.routes.draw do

  namespace :admin do
    root "static_pages#index"
    resources :courses, only: [:index, :new, :create]
    resources :subjects
    resources :users
  end
  root "static_pages#index"
  devise_for :users
  resources :user_courses do
    resources :user_subjects
  end
  resources :users, only: :show
end
