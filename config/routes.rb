Rails.application.routes.draw do
  root :to => "currencies#index"

  resources :countries, :except => [:new, :destroy]
  resources :currencies, :only => [:index, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
