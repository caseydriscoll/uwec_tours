class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.string :uri
      t.string :label
      t.string :contentType
      t.string :method, :default => "GET"
      t.string :params
      t.integer :activityType, :default => 0
      t.boolean :showActivity, :default => true
      t.string :activityMessage
      t.boolean :closeBiw, :default => false
      t.integer :autoTriggerRange
      t.boolean :autoTrigger, :default => false
      t.boolean :autoTriggerOnly, :default => false
      t.belongs_to :interactionable, :polymorphic => true
      
      t.references :interactionable

      t.timestamps
    end
  end
end
