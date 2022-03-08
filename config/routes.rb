Rails.application.routes.draw do
  get '/rooms/meetings', to: 'meetings#all_meetings'

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
end
