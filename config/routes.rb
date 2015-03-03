Rails.application.routes.draw do

  root to: 'visitors#index'

  devise_for :users, controllers: { sessions: "user/sessions", registrations: "user/registrations" }
  
  resources :users

  resources :developer

  resources :skill

  resources :project

  resources :client


  resources :developer do
    resources :developer_has_skills
  end

end
