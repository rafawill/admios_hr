Rails.application.routes.draw do
  # get 'developer/index'

  # get 'developer/show'

  # get 'developer/create'

  root to: 'visitors#index'

  devise_for :users, controllers: { sessions: "user/sessions", registrations: "user/registrations" }
  resources :users

  # get '/developer' => 'developer#index', as: 'developer_path'
  resources :developer

end
