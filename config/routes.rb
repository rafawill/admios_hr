Rails.application.routes.draw do
  root to: 'visitors#index'
  #devise_for :users
  devise_for :users, controllers: { sessions: "user/sessions", registrations: "user/registrations" }
  resources :users
end
