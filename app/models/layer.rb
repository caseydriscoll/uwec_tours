class Layer < ActiveRecord::Base
  attr_accessible :biwStyle, :description, :fullRefresh, :iconUrl, :name, :layer_type, :radius, :refreshDistance, :refreshInterval, :showMessage, :title

  has_many :hotspots
  has_many :interactions, :as => :interactionable
  has_many :animations, :as => :animatable

  validates_presence_of :name

  after_create :set_default_type

  def set_default_type
    self.layer_type = 'Geo' if self.layer_type.blank? # Optionally set to 'Visual'
    self.save
    true
  end

end
