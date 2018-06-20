Rails.application.routes.draw do
  get 'sessions/new'

  resources :blogs do
    collection do
      post :confirm
    end
    collection do
      get :top
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :favorites, only:[:create, :destroy]

  mount LetterOpenerWeb::Engine, at: "/inbox"
end
