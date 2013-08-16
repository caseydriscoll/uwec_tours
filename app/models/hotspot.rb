class Hotspot < ActiveRecord::Base
  attr_accessible :altitude, :biwStyle, :ciwIcon_type, :ciwIcon_url, :description, :footnote, :image_url, :inFocus, :latitude, :longitude, :showBiwOnClick, :showSmallBiw, :title, :interactions_attributes, :hotspot_object_attributes

  belongs_to :layer

  has_many :interactions, :as => :interactionable
  accepts_nested_attributes_for :interactions, :allow_destroy => :true, :reject_if => proc { |attributes| attributes['label'].blank? }

	has_one :hotspot_object
  accepts_nested_attributes_for :hotspot_object, :allow_destroy => :true

  validates_presence_of :title, :latitude, :longitude
  validates_uniqueness_of :title


end
