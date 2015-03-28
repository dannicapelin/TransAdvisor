Rails.application.routes.draw do
  resources :institutions
  resources :reviews
  root 'page#index'
end
