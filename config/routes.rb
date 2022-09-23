Rails.application.routes.draw do
  resources :reviews
  resources :messages
  resources :meals
  resources :attendances
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }
  get '/me', to: 'members#show_me'
  put '/update_me', to: 'members#update_me'
  get '/users_list', to: 'members#index'
  get '/user_detail/:id', to: 'members#show_user'
  post '/join_categories', to: 'join_category_meals#create'
  delete '/join_categories/:id', to: 'join_category_meals#destroy'
  get '/categories/:id', to: 'meals#get_meal_categories'
  post '/charges', to: 'charges#create'
  get 'conversation/:id', to: 'messages#get_conversation'
  get 'last_message/:id', to: 'messages#get_last_message'
  get 'host_reviews/:id', to: 'reviews#get_host_reviews'
  get 'guests_avatar/:id', to: 'meals#get_guests_avatar_url'
end
