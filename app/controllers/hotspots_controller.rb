class HotspotsController < ApplicationController
#	before_filter :login_required
	cache_sweeper :hotspot_sweeper

  def index
  end

  def new
    @layer = Layer.find params[:layer_id]
    @hotspot = @layer.hotspots.new
		# Default values for Eau Claire WI
			@hotspot.latitude = 44.79835779383246 
			@hotspot.longitude = -91.49950504232788
    @interaction = @hotspot.interactions.new
			@interaction.contentType = "text/html"
			@interaction.activityType = 1
		@hotspot_object = @hotspot.build_hotspot_object
			@hotspot_object.contentType = "image/vnd.layar.generic"
  end

  def create
    @layer = Layer.find params[:layer_id]
    @hotspot = @layer.hotspots.create params[:hotspot]
    if @hotspot.save
      render "show", :notice => 'Hotspot was successfully created.' 
    else
      render :action => "new"
    end

  end

  def edit
    @layer = Layer.find params[:layer_id]
    @hotspot = @layer.hotspots.find params[:id]
    @interaction = @hotspot.interactions.new
			@interaction.contentType = "text/html"
			@interaction.activityType = 1
		if !@hotspot.hotspot_object then 
			@hotspot.build_hotspot_object
			@hotspot.hotspot_object.contentType = "image/vnd.layar.generic"
		end
  end

  def update
    layer = Layer.find params[:layer_id]
    hotspot = layer.hotspots.find params[:id]
    if hotspot.update_attributes params[:hotspot]
      redirect_to layer_hotspot_path(layer, hotspot), :notice => 'Hotspot successfully updated.'
    else
      redirect_to :back, :notice => 'Hotspot not updated.'
    end
  end

  def destroy
    @layer = Layer.find params[:layer_id]
    @layer.hotspots.destroy params[:id]

    redirect_to layer_path(@layer), :notice => 'Hotspot successfully deleted'
  end

  def show
    @layer = Layer.find params[:layer_id]
    @hotspot = @layer.hotspots.find params[:id]
		@object = @hotspot.hotspot_object
  end
end
