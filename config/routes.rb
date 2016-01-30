Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  root to: 'home#index'
  namespace 'api' do
    get 'users/current', to: 'users#current'
    resources :users
    resources :matches
    resources :skins
    resources :bets
    resources :payouts
  end
end
