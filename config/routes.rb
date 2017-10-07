Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  resources :visits do
    post :photo, on: :collection
    post :audio, on: :collection
    post :correct, on: :collection
  end
  devise_for :users
  root to: 'visits#index'

  match '/about', to: 'pages#about', via: :get

end
