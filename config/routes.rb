Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions:      'users/sessions'
  }
  root 'static_pages#home'
  resources :users, only: [:show] do
    resources :projects
    resources :addresses, only: [:index, :create, :destroy]
  end
  resources :projects
  get  '/dashboard', to: 'users#dashboard', as: :dashboard
end
