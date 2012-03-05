class CreateAssetPlatforms < ActiveRecord::Migration
  def self.up
    create_table :asset_platforms do |t|
      t.column :name, :string
      t.column :position, :integer
      t.column :asset_and_asset_platforms_count, :integer, :default => 0
    end
    AssetPlatform.create([
      {:name => "IOS", :position => 1},
      {:name => "Android", :position => 2},
      {:name => "Bada", :position => 3},
      {:name => "BlackBerry", :position => 4}
      ])
  end

  def self.down
    drop_table :asset_platforms
  end
end
