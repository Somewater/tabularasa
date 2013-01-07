Himholod::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  
  resources :sections, :only => [:show]
  match 'sitemap.xml' => 'sitemaps#sitemap'
  match "search", :to => 'search#search_words'
  root :to => 'sections#show'
  match 'not_found' => 'main_page#not_found', :as => 'not_found'
  match '*paths' => 'main_page#not_found'
end
