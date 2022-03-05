Rails.application.routes.draw do
  resources :schedules
  resources :rooms

  devise_for :users, defaults: { formats: :json },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/welcome-msg', to: 'welcomes#show'
end
