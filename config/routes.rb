require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }
  root 'static_pages#home'
  resources :users, only: [:show] do
    resources :addresses, only: [:index, :create, :destroy]
    member do
      get 'activate_teacher'
    end
    collection do
      get 'apply_teacher'
    end
  end
  resources :projects
  get '/dashboard', to: 'users#dashboard', as: :dashboard

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
