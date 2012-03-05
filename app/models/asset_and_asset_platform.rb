class AssetAndAssetPlatform < ActiveRecord::Base
  unloadable
  belongs_to :asset
  belongs_to :asset_platform, :counter_cache => true
end
