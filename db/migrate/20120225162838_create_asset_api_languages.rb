class CreateAssetApiLanguages < ActiveRecord::Migration
  def self.up
    create_table :asset_api_languages do |t|
      t.column :name, :string
      t.column :position, :integer, :default => 0
      t.column :asset_and_api_languages_count, :integer, :default => 0
    end
    AssetApiLanguage.create([
        {:name => "C++", :position => 1},
        {:name => "Javascript Binding", :position => 2},
        {:name => "Lua binding", :position => 3}
      ])
  end

  def self.down
    drop_table :asset_api_languages
  end
end
