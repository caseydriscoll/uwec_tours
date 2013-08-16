class Animation < ActiveRecord::Base
  attr_accessible :animatable_id, :animatable_type, :axisX, :axisY, :axisZ, :delay, :event, :from, :interpolation, :interpolationParam, :length, :persist, :repeat, :to, :type
  belongs_to :interactionable, :polymorphic => true

end
