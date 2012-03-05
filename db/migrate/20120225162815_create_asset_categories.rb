class CreateAssetCategories < ActiveRecord::Migration
  def self.up
    create_table :asset_categories do |t|
      t.column :name, :string
      t.column :position, :integer, :default => 0
      t.column :assets_count, :integer, :default => 0
    end
    AssetCategory.create([
      {:name => "Graphic", :position => 1},
      {:name => "GUI", :position => 2},
      {:name => "Ads & Social", :position => 3},
      {:name => "Tools & Editors", :position => 4},
      {:name => "Tutorials", :position => 5},
      {:name => "SampleCode", :position => 6}
      ])
  end

  def self.down
    drop_table :asset_categories
  end
end
