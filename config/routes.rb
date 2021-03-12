Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    authenticated :user do
      root :to => 'profiles#new', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
      post 'users/guest1_sign_in', to: 'users/sessions#new_guest1'
      post 'users/guest2_sign_in', to: 'users/sessions#new_guest2'
    end
  end
  resources :profiles
  resources :events do
    resources :favorites, only: [:create, :destroy, :destroy_from_lists] do
      delete 'destroy_from_lists', :on => :member
    end
    member do
      get :apply_members, :complete
    end
    get 'search_top', :on => :collection
  end

  resources :users, only: [:my_event, :event_history, :joined_event_history, :favorite_lists] do
    member do
      get :my_event, :event_history, :joined_event_history, :favorite_lists
    end
  end

  resources :apply_for_events, only: [:create, :destroy, :toggle_status, :cancel_mail, :cancel_status] do
    patch :toggle_status
      member do
        get :cancel_mail, :cancel_status, :cancel
      end
    get "cancel_complete", :on => :collection
  end
  resources :rooms do
    resources :messages
  end
  resources :evaluations, only: [:create, :rating, :rated] do
    member do
      get :rating
      get :rated
    end
  end

  get 'restaurants', to:'restaurants#index'
  get 'api', to: 'restaurants#api'

  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
