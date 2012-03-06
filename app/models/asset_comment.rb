class AssetComment < ActiveRecord::Base
  unloadable
  belongs_to :asset, :counter_cache => true
  belongs_to :user
  has_attached_file :attachment,
    :url => "/:class/:attachment/:id/:style_:basename.:extension",
    :path => ":rails_root/public/:class/:attachment/:id/:style_:basename.:extension"
  acts_as_attachable
end
