class InteractionsController < ApplicationController
#	before_filter :login_required

  before_filter :load_interactionable

  def index
  end

  def new
    @layer = Layer.find params[:layer_id]
    @interaction = @interactionable.interactions.new
  end

  def create
    @layer = Layer.find params[:layer_id]
    @interaction = @interactionable.interactions.create params[:interaction]
    if @interaction.save
      redirect_to @interactionable, :notice => "Action successfully created."
    else
      redirect_to new_layer_interaction_path(@layer, @interaction), :notice => "Action not created."
    end
  end

  def edit
    @layer = Layer.find params[:layer_id]
    @interaction = @interactionable.interactions.find params[:id]
  end

  def update
    layer = Layer.find params[:layer_id]
    interaction = @interactionable.interactions.find params[:id]
    if interaction.update_attributes params[:interaction]
      redirect_to layer_interaction_path(layer, interaction), :notice => 'Action successfully updated.'
    else
      redirect_to :back, :notice => 'Action not updated.'
    end
  end

  def destroy
    @interactionable.interactions.destroy params[:id]

    redirect_to :back, :notice => "Action successfully deleted."
  end

  def show
    @layer = Layer.find params[:layer_id]
    @interaction = @interactionable.interactions.find params[:id]
  end

  private

    def load_interactionable
      resource, id = request.path.split('/')[1, 2]
      @interactionable = resource.singularize.classify.constantize.find(id)
    end
end
