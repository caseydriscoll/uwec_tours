class HotspotObject < ActiveRecord::Base
  attr_accessible :contentType, :hotspot_object_url, :previewImage, :reducedUrl, :rotateAngle, :rotateAxisX, :rotateAxisY, :rotateAxisZ, :rotateRel, :scale, :size, :translateX, :translateY, :translateZ

	belongs_to :hotspot
end
