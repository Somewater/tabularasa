Herbs::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  #scope "(:locale)", :locale => /ru|en/ do
    resources :products, :only => [:show, :index]
    resources :sections, :only => [:show]
    resources :text_pages, :only => [:show], :path => "pages"
    match 'sitemap.xml' => 'sitemaps#sitemap'
    match "search/(:page)", :to => 'search#search_words'
    match "sitemap", :to => 'sitemap#index', :as => 'sitemap'
  
    root :to => 'products#index'
    match 'not_found' => 'main_page#not_found', :as => 'not_found'
    match '*paths' => 'main_page#not_found'
  #end
end
