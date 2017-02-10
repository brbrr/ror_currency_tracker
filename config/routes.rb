Rails.application.routes.draw do
  # constraints subdomain: 'api' do
  #   scope module: 'api' do
  #     namespace :v1 do
  #       resources :countries, :except => [:new, :destroy]
  #       resources :currencies, :only => [:index, :show]
  #     end
  #   end
  # end

  root to: 'api/v1/countries#index'
  namespace :api do
    namespace :v1 do
      resources :countries, except: [:new, :destroy]
      resources :currencies, only: [:index, :show]

      get '/countries/visits-over-time', to: 'countries#visits_over_time'
      get '/countries/vs', to: 'countries#vs'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
