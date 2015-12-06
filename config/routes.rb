Rails.application.routes.draw do
  root 'home#index'
  resources :batters, :only => [:index], :defaults => { :format => 'json' }
end
