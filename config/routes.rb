Rails.application.routes.draw do
  resources :rooms do
    resources :schedules
  end

  devise_for :users, defaults: { formats: :json },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/welcome-msg', to: 'welcomes#show'
end
