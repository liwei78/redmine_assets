class AssetApiLanguage < ActiveRecord::Base
  acts_as_list
  has_many :asset_and_api_language
  has_many :assets, :through => :asset_and_api_language
end
