Rails.application.routes.draw do

  root to: 'visitors#index'

  devise_for :users, controllers: { sessions: "user/sessions", registrations: "user/registrations" }
  
  resources :users

  resources :developer

  resources :skill

  resources :project

  resources :client

  post '/search_skills/search/', to: 'search_skills#search'

  get 'search_skills/index/', to: 'search_skills#index'

  resources :search_skills

  resources :developer do
    resources :developer_has_skills
  end

  resources :developer do
    resources :developer_has_projects
  end

  resources :project do
    resources :project_has_skills
  end

end
