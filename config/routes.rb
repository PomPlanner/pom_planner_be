Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      post 'auth/google_oauth2', to: 'sessions#google_oauth2'
      get 'auth/google_oauth2', to: 'sessions#google_oauth2'
      get 'auth/google_oauth2/callback', to: 'sessions#omniauth'
      delete 'logout', to: 'sessions#destroy'
      get 'auth/failure', to: redirect('/')

      resources :users, only: [:show] do
        resources :videos, only: [:index, :create, :destroy]
        resources :events, only: [:new, :create] do
          collection do
            post 'generate_google_calendar_link'
          end
        end
      end

      get 'search', to: 'searches#index'
    end
  end
end
