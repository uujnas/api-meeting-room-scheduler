Rails.application.routes.draw do
  get 'rooms/index'
  get 'test/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users, defaults: { formats: :json },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/welcome-msg', to: 'welcomes#show'
  get '/test', to: 'test#index'
end
