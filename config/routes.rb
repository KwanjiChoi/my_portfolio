require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }
  root 'static_pages#home'
  get '/dashboard',                       to: 'users#dashboard',          as: :dashboard
  get '/users/:user_id/reservations/:id', to: 'reservations#show_active', as: :active_reservation

  resources :users, only: [:show] do
    resources :addresses,    only: [:index, :create, :destroy]
    resources :reservations, only: [:index]

    member do
      get 'activate_teacher'
      get 'projects'
      get 'teacher', to: 'reservations#teacher_index'
    end

    collection do
      get 'apply_teacher'
    end

    resources :comments, only: [:create], module: :users
  end

  resources :projects do
    member do
      get 'detail'
    end

    collection do
      get 'feed'
    end

    resources :reservations, except: [:show] do
      member do
        put 'confirm'
      end
    end

    resources :comments, only: [:create], module: :projects
  end

  get '/projects/:project_id/reservations/:id',
      to: 'reservations#show_passive', as: :passive_reservation

  resources :messages, only: [:create]
  resources :rooms,    only: [:show, :index]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
