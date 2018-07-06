Rails.application.routes.draw do
  devise_for :users
  resources :cities do
    member do
      post :update_temp
    end
  end

  namespace :api, :default => {:format => :json} do
    namespace :v1 do
      get "/trains" => 'trains#index', :as => :trains
      get "/trains/:train_number" => 'trains#show', :as => :train

      get "/reservations/:booking_code", to: 'reservations#show', as: :reservation
      post "/reservations", to: 'reservations#create', as: :create_reservations
      patch "/reservations/:booking_code", to: 'reservations#update', as: :update_reservation
      delete "/reservations/:booking_code", to: 'reservations#destroy', as: :cancel_reservation
      get '/reservations' => "reservations#index", as: :reservations

      post "/signup" => "auth#signup"
      post "/login" => 'auth#login'
      post '/logout' => 'auth#logout'
    end
  end

  root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
