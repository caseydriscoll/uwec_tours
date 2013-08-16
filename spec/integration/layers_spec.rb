require 'spec_helper'

describe Layer do 
  before do
		@user = User.create! :username => 'driscocp'
		CASClient::Frameworks::Rails::Filter.fake(@user)
    @layer = Layer.create :name => 'UWEC Main Tour'
  end

  describe 'displays layers' do
    it "displays title 'Layers'" do
      visit layers_path
      page.should have_content 'Layers'
    end
    it "displays all layers" do 
      visit layers_path
      page.should have_content 'UWEC Main Tour'
    end

    it "displays number of hotspots in layer" do
      @layer.hotspots.create :title =>'Hotspot 1', :latitude => '100.0', :longitude => '100.0'

      visit layers_path
      find(:css, '#layer_1 .hotspots').should have_content 1
    end

    it "displays whether layer has actions"   # displays an 'x' if false, '✓' if true
    it "displays whether layer has animation"
  end

  describe 'show layer' do
    it "clicks to view layer's details" do
      visit layers_path
      click_link 'Show'
      page.current_path.should == layer_path(@layer)
    end

    it "can go back to layers page" do
      visit layer_path(@layer)
      click_link 'Layers'
      page.current_path.should == layers_path
    end

    it "displays layer name" do
      visit layer_path(@layer)
      page.should have_content "UWEC Main Tour"
    end

    it "displays layer hotspots" do
      @layer.hotspots.create :title => 'Hotspot 1', :latitude => '100.0', :longitude => '100.0'

      visit layer_path(@layer)
      page.should have_content "Hotspot 1"
    end

    describe 'json shows' do
      it "page" do
        visit layer_path(@layer)
        click_link ".json"
        page.current_path.should == layer_path(@layer) + '.json'
      end

      it "objects"
      it "actions"
      it "animations"
    end
    
  end

  describe 'new layer' do
    it "makes a new layer" do
      visit layers_path
      fill_in 'layer[name]', :with => 'UWEC Davies Tour'
      click_button 'Create Layer'

      current_path.should == layers_path
      page.should have_content "UWEC Davies Tour"
    end

    it "makes a new layer with default layer type of 'Geo'" do
      visit layers_path
      page.should have_content "Geo"
      # save_and_open_page
    end
  end


  describe 'edit layer' do
    it "has link to edit a layer's properties" do
      visit layers_path
      click_link 'Edit'
      page.current_path.should == edit_layer_path(@layer)
    end

    it "edits a layer's name" do
      visit layers_path
      click_link 'Edit'
      fill_in 'Name', :with => 'UWEC Tour'
      click_button "Update Layer"
    end

    it "edits a layer's type" do
      visit layers_path
      click_link 'Edit'
      choose 'Visual'
      click_button "Update Layer"
    end

    it "cancels an edit" do
      visit edit_layer_path(@layer)
      click_link 'Cancel'
      current_path.should == layers_path
    end
  end

  describe 'delete layer' do
    it "should delete a layer" do
      visit layers_path
      click_link 'Delete'
			#click_link 'Yes, I\'m positively certain.'
      #page.should_not have_content "UWEC Main Tour"
    end

		it "verifies that user wants to delete layer" do
			visit layers_path
			click_link 'Delete'
			#page.should have_content "Are you sure you want to delete 'Hotspot 1'?"
		end
	end

  describe 'Validation' do
    it "does not allow an empty layer" do
      visit layers_path
      click_button "Create Layer"
      page.should have_content "Name can't be blank"
    end
    it "does not allow an empty layer on edit"
  end
 
end
