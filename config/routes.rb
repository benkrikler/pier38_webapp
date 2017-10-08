Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  resources :visits do
    post :photo, on: :collection
    get :audio
    post :audio_update
    get :questions
    post :questions_update
    get :result
  end
  devise_for :users
  root to: 'visits#index'

  match '/about', to: 'pages#about', via: :get

end
