class LayerSweeper < ActionController::Caching::Sweeper
  observe Layer
 
	def sweep(layer)
		expire_page :controller => "/layers", :action => "show", :id => layer.id, :format => :json
		cache_page :controller => "/layars", :action => "show", :id => layer.id, :format => :json
	end
	
	alias_method :after_create, :sweep
	alias_method :after_save, :sweep
	alias_method :after_destroy, :sweep
end
