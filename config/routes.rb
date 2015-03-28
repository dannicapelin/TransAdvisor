Rails.application.routes.draw do
  root 'page#index'
  get '/about', to: 'page#about'
  get '/guides', to: 'page#guides'

  resources :institutions do
    resources :reviews, except: [:index]
  end
end
