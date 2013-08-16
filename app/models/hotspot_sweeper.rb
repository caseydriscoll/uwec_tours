class HotspotSweeper < ActionController::Caching::Sweeper
  observe Hotspot
 
	def sweep(hotspot)
		expire_page :controller => "/layers", :action => "show", :id => hotspot.layer_id, :format => :json
		cache_page :controller => "/layars", :action => "show", :id => hotspot.layer_id, :format => :json
	end
	
	alias_method :after_create, :sweep
	alias_method :after_save, :sweep
	alias_method :after_destroy, :sweep
end
