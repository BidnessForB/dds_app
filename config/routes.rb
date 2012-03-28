DdsApp::Application.routes.draw do
  
  resources :teasers

  resources :products

  resources :photos

  resources :photographers

  resources :galleries do
    resources :photos
  end

  resources :gallery_categories

  resources :news

  resources :events

  resources :event_types

  match 'calendar' => 'events#index', :as => :calendar
  
  match 'px' => 'products#px', :as => :px

  get "pages/home"
  get "pages/VMB612"
  get "pages/PBJs"
  get "pages/squadron"
  
  
  root :to => 'pages#home'

   match ':controller(/:action(/:id(.:format)))'
end
