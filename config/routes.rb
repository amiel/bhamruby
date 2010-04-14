ActionController::Routing::Routes.draw do |map|
  map.resources :companies

  map.resources :events

  map.resources :people

  map.resources :projects

  map.resource :session, 
    :member => {:close => :get}
  

  map.root :controller => "root"
  map.connect '/:action', :controller => "root"

  # we don't need these right?
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
