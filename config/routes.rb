Rails.application.routes.draw do
  resources :visits do
    post :photo, on: :collection
    post :audio, on: :collection
    post :correct, on: :collection
  end
  devise_for :users
  root to: 'visits#index'
end
