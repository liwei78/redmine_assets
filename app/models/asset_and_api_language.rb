class AssetAndApiLanguage < ActiveRecord::Base
  unloadable
  belongs_to :asset
  belongs_to :asset_api_language, :counter_cache => true
end
