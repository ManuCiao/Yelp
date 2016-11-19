Rails.application.routes.draw do
    root 'restaurants#index'
    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
    resources :restaurants do
        resources :reviews
    end
end
