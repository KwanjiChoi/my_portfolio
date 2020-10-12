Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  get  '/dashboard', to: 'users#show', as: :my_page
end
