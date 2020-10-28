Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }
  root 'static_pages#home'
  resources :users, only: [:show] do
    resources :addresses, only: [:index, :create, :destroy]
  end
  resources :projects
  get '/dashboard', to: 'users#dashboard', as: :dashboard

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
