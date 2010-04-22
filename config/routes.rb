AuthExample::Application.routes.draw do |map|
  match 'logout' => "user_sessions#destroy"
  
  resources :users
  resource :user_session
  resource :account, :controller => "users"
  
  root :to => "user_sessions#new" # optional, this just sets the root route

end
