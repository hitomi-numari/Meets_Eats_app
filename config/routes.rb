Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
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
    get 'apply_members', :on => :member
    get 'complete', :on => :member
    get 'search_top', :on => :collection
    get 'rating', :on => :member
  end
  resources :users, only: [:my_event, :event_history, :joined_event_history] do
    get "my_event", :on => :member
    get "event_history", :on => :member
    get "joined_event_history", :on => :member
  end
  resources :apply_for_events, only: [:create, :destroy, :toggle_status, :cancel_mail, :cancel_status] do
    patch :toggle_status
    get "cancel_mail", :on => :member
    get "cancel_status", :on => :member
    get "cancel_complete", :on => :collection
    get "cancel", :on => :member
  end
  resources :rooms do
    resources :messages
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
