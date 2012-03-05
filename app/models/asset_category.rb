class AssetCategory < ActiveRecord::Base
  acts_as_list
  has_many :assets
end
