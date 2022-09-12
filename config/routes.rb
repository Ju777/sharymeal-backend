Rails.application.routes.draw do
  resources :meals
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  get '/me', to: 'members#show_me'
  get '/guested_meals', to: 'members#guested_meals'
  put '/update_me', to: 'members#update_me'
  get '/users_list', to: 'members#index'
  get '/user_detail/:id', to: 'members#show_user'
  # post 'add_avatar', to:'members#add_avatar'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
