class CreateAssetAndAssetPlatforms < ActiveRecord::Migration
  def self.up
    create_table :asset_and_asset_platforms do |t|
      t.column :asset_id, :integer
      t.column :asset_platform_id, :integer
    end
  end

  def self.down
    drop_table :asset_and_asset_platforms
  end
end
