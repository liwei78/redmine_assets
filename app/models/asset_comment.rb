class AssetComment < ActiveRecord::Base
  unloadable
  belongs_to :asset, :counter_cache => true
  belongs_to :user
end
