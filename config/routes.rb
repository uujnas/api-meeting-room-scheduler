Rails.application.routes.draw do
  resources :rooms do
    resources :meetings do
      resources :schedules
    end
  end

  devise_for :users, defaults: { formats: :json },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get '/welcome-msg', to: 'welcomes#show'
end
