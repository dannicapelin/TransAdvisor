Rails.application.routes.draw do
  resources :reviews
  root 'page#index'
end
