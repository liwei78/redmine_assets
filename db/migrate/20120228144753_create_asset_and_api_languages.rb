class CreateAssetAndApiLanguages < ActiveRecord::Migration
  def self.up
    create_table :asset_and_api_languages do |t|
      t.column :asset_id, :integer
      t.column :asset_api_language_id, :integer
    end
  end

  def self.down
    drop_table :asset_and_api_languages
  end
end
