Rails.application.routes.draw do
    root to: 'games#index'
    resources :games , only: [:index,:show, :create, :update, :destroy] do
      resources :words, only: [:index, :new, :update, :create]
    end


    get '/games/:id/timer', to: 'games#timer', as: 'timer'

end
