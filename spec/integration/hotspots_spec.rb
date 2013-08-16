require 'spec_helper'

describe Hotspot do 

  before do
		@user = User.create! :username => 'driscocp'
		CASClient::Frameworks::Rails::Filter.fake(@user)
    @layer = Layer.create :name => 'Test Layer'
    @hotspot = @layer.hotspots.create :title => "Hotspot 1", :latitude => 100, :longitude => 100
		@hotspot.interactions.create :label => "Action 1", :uri => "http://google.com"
		@hotspot.build_hotspot_object :hotspot_object_url => "http://google.com", :size => "50.0"
  end

  it "displays important hotspot parameters on layer show page" do
		# only lat, lon, alt, title, desc, footnote, image preview
		visit layer_path(@layer)

		page.should have_content "Hotspot 1"
		page.should have_content "Lat:100.0"
		page.should have_content "Lon:100.0"
	end 
  
  describe "show" do
    it "displays all information" do
			visit layer_path(@layer)
			click_link "Show"
			page.should have_content "Hotspot 1"
			page.should have_content "Latitude:100.0"
			page.should have_content "Longitude:100.0"
		end

    it "displays hotspot_object" do
			visit new_layer_hotspot_path(@layer, @hotspot)
			
    	fill_in "Title", :with => "Hotspot 2"
    	fill_in "Lat:", :with => "100.0"
    	fill_in "Lon:", :with => "100.0"

			fill_in "Size", :with => "50.0"

			first(:button, "Create Hotspot").click
      page.should have_content "1 Object"
		end

		it "displays count of actions" do
			visit layer_hotspot_path(@layer, @hotspot)
			page.should have_content "1 Action"
		end

    it "displays actions" do
			visit layer_hotspot_path(@layer, @hotspot)
			page.should have_content "Action 1"
			page.should have_content "http://google.com"
		end

    it "displays animations"

    it "click to show hotspot" do
      visit layer_path(@layer)
      click_link "Show"

      page.should have_content "Hotspot 1"
    end
  end

	describe "edit" do
  	it "edits main hotspot parameters" do 
    	visit layer_path(@layer)
    	click_link "Add Hotspot"
    	fill_in "Title", :with => "Hotspot 2"
    	fill_in "Lat:", :with => "100.0"
    	fill_in "Lon:", :with => "100.0"

    	first(:button, "Create Hotspot").click
    	click_link "Back to Layer"
    	#click_link "Edit"
      first(:link, "Edit").click

    	fill_in "Title", :with => "Updated Hotspot"

    	#click_button "Update Hotspot"
      first(:button, "Update Hotspot").click
    	page.should have_content "Hotspot successfully updated"
  	end

		it "updates an old hotspot action"
		it "updates an old hotspot object" do
			visit edit_layer_hotspot_path(@layer, @hotspot)

			fill_in "Size", :with => "20.0"
			first(:button, "Update Hotspot").click
			page.should have_content "20.0"
		end
		it "updates an old hotspot animation"

		it "deletes an old hotspot action"
		it "deletes an old hotspot object"
		it "deletes an old hotspot animation"
	end  


  it "should delete a hotspot" do
    visit layer_path(@layer)
    click_link "Add Hotspot"
    fill_in "Title", :with => "Hotspot 2"
    fill_in "Lat:", :with => "100.0"
    fill_in "Lon:", :with => "100.0"

    first(:button, "Create Hotspot").click
    click_link "Back to Layer"
    find('#hotspot_2').click_link "Delete"

    page.should_not have_content "Hotspot 2"
  end

  describe 'create' do
    it "adds a new hotspot" do
      visit layer_path(@layer)
      click_link "Add Hotspot"
      fill_in "Title", :with => "Hotspot 3"
      fill_in "Lat:", :with => "100.0"
      fill_in "Lon:", :with => "100.0"

      #click_button "Create Hotspot"
      first(:button, "Create Hotspot").click
      page.should have_content "Hotspot 3"
    end

		it "adds a new hotspot action" do
			visit layer_path(@layer)
			click_link "Add Hotspot"
      fill_in "Title", :with => "Hotspot 3"
      fill_in "Lat:", :with => "100.0"
      fill_in "Lon:", :with => "100.0"
			fill_in "Label", :with => "More information"
			
			#click_button "Create Hotspot"
      first(:button, "Create Hotspot").click
			page.should have_content "More information"
		end

		it "adds a new hotspot object" do
			visit layer_path(@layer)
			click_link "Add Hotspot"
      fill_in "Title", :with => "Hotspot 3"
      fill_in "Lat:", :with => "100.0"
      fill_in "Lon:", :with => "100.0"

			fill_in "Size", :with => "50.0"
			
      first(:button, "Create Hotspot").click
			page.should have_content "1 Object"
		end
			
		it "adds a new hotspot animation"
    
		it "cancels a creation" do
      visit layer_path(@layer)
      click_link "Add Hotspot" 
      #click_link "Cancel"
      first(:link, "Cancel").click

      page.current_path.should == layer_path(@layer)
    end
		
    it "links back to layer page" do
      visit layer_path(@layer)
      click_link "Add Hotspot"
      fill_in "Title", :with => "Hotspot 3"
      fill_in "Lat:", :with => "100.0"
      fill_in "Lon:", :with => "100.0"

      #click_button "Create Hotspot"
      first(:button, "Create Hotspot").click
      click_link "Back to Layer"
      page.current_path.should == layer_path(@layer)
    end
  end

  describe 'validation' do
		it "does not allow blank objects"
    it "does not allow blank hotspots" do
      visit layer_path(@layer)
      click_link "Add Hotspot"
      #click_button "Create Hotspot"
      first(:button, "Create Hotspot").click

      page.should have_content "Title can't be blank"
      # Lat and Long are no longer blank because of the map plugin initialization
			#page.should have_content "Latitude can't be blank"
      #page.should have_content "Longitude can't be blank"
    end

    it "does not allow duplicate entries" do
      visit layer_path(@layer)
      click_link "Add Hotspot"
      fill_in "Title", :with => "Hotspot 1"
      fill_in "Lat:", :with => "100"
      fill_in "Lon:", :with => "100"

      #click_button "Create Hotspot"
      first(:button, "Create Hotspot").click

      page.should have_content "Title has already been taken"
    end
  end

end
