class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.integer  :user_id
      t.string   :name
      t.text     :description
      t.string   :author
      t.string   :website
      t.string   :compatible_with
      
      t.string   :icon_file_name
      t.string   :icon_content_type
      t.integer  :icon_file_size
      t.datetime :icon_updated_at
      
      t.string   :attachment_file_name
      t.string   :attachment_content_type
      t.integer  :attachment_file_size
      t.datetime :attachment_updated_at
      
      t.boolean  :top, :default => false
      t.integer  :asset_category_id
      t.integer  :views_count, :default => 0
      t.integer  :asset_comments_count, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
