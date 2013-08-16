class Interaction < ActiveRecord::Base
  attr_accessible :activityMessage, :activityType, :autoTrigger, :autoTriggerOnly, :autoTriggerRange, :closeBiw, :contentType, :label, :method, :params, :showActivity, :uri
  belongs_to :interactionable, :polymorphic => true

  # validates_presence_of :label, :uri, :activityType, :method

  after_create :set_defaults

  def set_defaults
    self.activityType = '1'
    self.method = 'GET'
    self.save
    true
  end
end
