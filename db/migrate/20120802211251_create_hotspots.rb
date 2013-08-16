class CreateHotspots < ActiveRecord::Migration
  def change
    create_table :hotspots do |t|
      t.float :latitude
      t.float :longitude
      t.float :altitude
      t.string :title
      t.string :description
      t.string :footnote
      t.string :image_url
      t.boolean :showSmallBiw, :default => true
      t.boolean :showBiwOnClick, :default => true
      t.string :biwStyle, :default => "classic"
      t.string :ciwIcon_url
      t.integer :ciwIcon_type
      t.boolean :inFocus, :default => false
      
      t.references :layer
      t.references :hotspot_object

      t.timestamps
    end
  end
end
