# liwei created at 2012-2-20
# 0.0.1 basic
# 0.0.2 add jiathis to asset's view
# 0.0.3 chang some words
require 'redmine'

Redmine::Plugin.register :redmine_assets do
  name 'Redmine Assets plugin'
  author 'Riquel Li'
  description 'This is a plugin for Redmine to manage your assets.'
  version '0.0.3'
  url 'http://railser.cn'
  author_url 'http://railser.cn/me'

  settings :default => {},
           :partial => 'assets_manage/manage'

  project_module :assets do
    permission :manage_assets, {:assets => [:my, :edit, :update, :new, :create, :destroy, :recommend, :my, :postcomment, :delcomment]}, :require => :loggedin
    permission :view_assets, {:assets => [:index, :show, :all]}
  end

  menu :project_menu, :assets, {:controller => "assets", :action => "index"}, :caption => "Extensions", :param => :project_id

end

ActionController::Routing::Routes.draw do |map|
  map.resources :assets, :member => {:recommend => :post, :postcomment => :post, :delcomment => :post}, :collection => {:my => :get, :all => :get}
  map.resources :asset_api_languages
  map.resources :asset_categories
  map.resources :asset_platforms
  map.connect 'projects/:project_id/assets', :controller => "assets", :action => "index", :conditions => {:method => :get}
  map.connect 'projects/:project_id/assets/:id', :controller => "assets", :action => "show", :conditions => {:method => :get}
end
