class CreateAssetComments < ActiveRecord::Migration
  def self.up
    create_table :asset_comments do |t|
      t.column :user_id, :integer
      t.column :asset_id, :integer
      t.column :comment, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :asset_comments
  end
end
