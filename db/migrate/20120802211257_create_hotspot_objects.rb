class CreateHotspotObjects < ActiveRecord::Migration
  def change
    create_table :hotspot_objects do |t|
      t.string :contentType
      t.string :hotspot_object_url
      t.float :size
      t.string :reducedUrl
      t.string :previewImage
      t.boolean :rotateRel
      t.float :rotateAxisX
      t.float :rotateAxisY
      t.float :rotateAxisZ
      t.float :rotateAngle
      t.float :translateX
      t.float :translateY
      t.float :translateZ
      t.float :scale

      t.references :hotspot

      t.timestamps
    end
  end
end
