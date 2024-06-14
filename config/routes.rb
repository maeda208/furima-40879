Rails.application.routes.draw do
  get 'articles/index'
  get 'articles/new'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
root to:'items#index'
resources :items, only:[:index,:create,:new]
resources :articles
  # Defines the root path route ("/")
  # root "articles#index"
end
