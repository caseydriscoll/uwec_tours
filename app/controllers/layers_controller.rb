class LayersController < ApplicationController
	caches_page :show, :if => lambda { |c| c.request.format.json? }
	cache_sweeper :layer_sweeper
#	before_filter :login_required, :except => [:show]
	before_filter(:only => :show) do |controller|
#    login_required unless controller.request.format.json?
  end

  def index
      @layers = Layer.all
      @layer = Layer.new
  end

  def create
    @layer = Layer.new params[:layer]
    if @layer.save
      redirect_to :back, :notice => 'Layer was successfully created.'
    else
      @layers = Layer.all
      render :action => "index"
    end
  end

  def edit
    @layer = Layer.find params[:id]
  end

  def update
    layer = Layer.find params[:id]
    if layer.update_attributes params[:layer]
      redirect_to layers_path, :notice => 'Layer was successfully updated.'
      expire_action :action => :index, :format => :json
    else
      redirect_to :back
    end

  end

  def destroy
    Layer.destroy params[:id]

    redirect_to :back
  end

  def show
    @layer = Layer.find params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :partial => "layers/show" }
    end
  end
end
