class CreateLayers < ActiveRecord::Migration
  def change
    create_table :layers do |t|
      t.string :name
      t.string :layer_type
      t.integer :radius
      t.integer :refreshInterval, :default => 300
      t.integer :refreshDistance, :default => 100
      t.boolean :fullRefresh, :default => true
      t.string :showMessage
      t.string :title
      t.string :description
      t.string :iconUrl
      t.string :biwStyle

      t.timestamps
    end
  end
end
