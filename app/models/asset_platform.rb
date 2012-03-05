class AssetPlatform < ActiveRecord::Base
  unloadable
  acts_as_list
  has_many :asset_and_asset_platforms
  has_many :assets, :through => :asset_and_asset_platforms
end
