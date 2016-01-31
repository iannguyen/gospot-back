Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  root to: 'home#index'
  namespace 'api' do
    resources :users, only: [:index]
    resources :matches, only: [:index, :show]
    resources :skins, only: [:index, :create, :destroy]
    resources :bets, only: [:index, :create, :destroy]
    resources :payouts, only: [:destroy]
  end
end
