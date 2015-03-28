Rails.application.routes.draw do
  root 'page#index'

  resources :institutions do
    resources :reviews, except: [:index]
  end
end
