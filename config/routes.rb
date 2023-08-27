Rails.application.routes.draw do
  namespace :drawapi, defaults: { format: :json } do
    namespace :v1 do
      resources :rounds, only: [ :index, :show, :destroy, :create ] do
        resources :participants, only: [ :index, :show, :create, :update ], controller: 'round_participants'
      end
      post 'login', to: 'sessions#login', as: :login
    end
  end

  namespace :drawadmin do
    # resources :users, only: [ :index, :destroy ]
    resources :rounds, only: [ :index, :destroy ]
  end

end
