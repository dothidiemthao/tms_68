Rails.application.routes.draw do
  require "sidekiq/web"

  namespace :admin do
    mount Sidekiq::Web => "/sidekiq"
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
