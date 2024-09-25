Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :payments, except: [:update, :edit] do
        post :refund_payment, on: :member
      end
      resources :organisations
      get 'organisations_activity', to: 'organisations#payments_activity'
    end
  end
  mount PaymentEngine::Engine, at: '/payment_engine'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
