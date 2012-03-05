class Asset < ActiveRecord::Base
  
  validates_presence_of :name
  validates_presence_of :asset_category_id
  
  
  has_attached_file :icon,
    :styles => {:original => "160x160#", :thumb => "60x60#"},
    :url => "/:class/:attachment/:id/:style_:basename.:extension",
    :path => ":rails_root/public/:class/:attachment/:id/:style_:basename.:extension",
    :default_url => "default_asset.jpg"
    
  has_attached_file :attachment,
    :url => "/:class/:attachment/:id/:style_:basename.:extension",
    :path => ":rails_root/public/:class/:attachment/:id/:style_:basename.:extension"
  
  has_many :asset_and_asset_platforms
  has_many :asset_platforms, :through => :asset_and_asset_platforms
  has_many :asset_and_api_languages
  has_many :asset_api_languages, :through => :asset_and_api_languages
  belongs_to :asset_category, :counter_cache => true
  has_many :asset_comments

    
  def self.recommends(n=6)
    find(
      :all,
      :select => "assets.*, asset_categories.name as category_name", 
      :joins => "left join asset_categories on asset_categories.id = assets.asset_category_id", 
      :conditions => ["top = ?", true],
      :limit => n,
      :order => "updated_at desc")
  end

  def self.last_updated(n=12)
    find(
      :all,
      :select => "assets.*, asset_categories.name as category_name", 
      :joins => "left join asset_categories on asset_categories.id = assets.asset_category_id", 
      :conditions => ["top = ?", false],
      :limit => n,
      :order => "updated_at desc")
  end
  
  # Mysql::Error: Unknown column 'asset_and_api_languages.asset_api_language_id' in 'on clause': SELECT `asset_api_languages`.* FROM `asset_api_languages`  INNER JOIN `asset_and_api_languages` ON `asset_api_languages`.id = `asset_and_api_languages`.asset_api_language_id    WHERE ((`asset_and_api_languages`.asset_id = 1)) 
  def kfc(platforms, apis)
    unless platforms.blank?
      self.asset_and_asset_platforms.each(&:destroy)
      self.asset_platforms << AssetPlatform.find(platforms)
    end
    unless apis.blank?
      self.asset_and_api_languages.each(&:destroy)
      self.asset_api_languages << AssetApiLanguage.find(apis)
    end
  end

  
end
