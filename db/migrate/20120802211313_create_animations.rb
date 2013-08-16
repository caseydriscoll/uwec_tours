class CreateAnimations < ActiveRecord::Migration
  def change
    create_table :animations do |t|
      t.string :event
      t.string :type
      t.integer :length
      t.integer :delay, :default => 0
      t.float :interpolationParam
      t.string :interpolation
      t.boolean :persist, :default => false
      t.boolean :repeat, :default => false
      t.float :from
      t.float :to
      t.float :axisX
      t.float :axisY
      t.float :axisZ
      t.belongs_to :animatable, :polymorphic => true
      
      t.references :animatable

      t.timestamps
    end
  end
end
