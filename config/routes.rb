Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    authenticated :user do
      root :to => 'profiles#new', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  resources :profiles
  resources :events do
    get 'apply_members', :on => :member
    get 'complete', :on => :member
    get 'search_top', :on => :collection
  end
  resources :users, only: [:show, :my_events] do
    get "my_event", :on => :member
    get "event_history", :on => :member
    get "joined_event_history", :on => :member
  end
  resources :apply_for_events, only: [:create, :destroy, :apply_members, :complete] do
    patch :toggle_status
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
