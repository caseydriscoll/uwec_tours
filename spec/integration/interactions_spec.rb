require 'spec_helper'

describe Interaction do 

  before do
		@user = User.create! :username => 'driscocp'
		CASClient::Frameworks::Rails::Filter.fake(@user)
    @layer = Layer.create :name => 'Test Tour'
    @hotspot = @layer.hotspots.create :title => "Hotspot 1", :latitude => 100, :longitude => 100
    @interactionable = @layer
    @interaction = @interactionable.interactions.create :label => 'More Information', :uri => 'http://moreinformation.com'
  end

  describe 'belonging to Layer,' do 

    it 'goes to new page' do
      visit layer_path(@layer)
      click_link 'Add Action'
      page.current_path.should == new_layer_interaction_path(@layer)
    end

    it 'adds action to layer' do
      visit layer_path(@layer)
      click_link 'Add Action'

      fill_in "Label", :with => "More information"
      fill_in "URI", :with => "http://moreinformation.com"

      click_button "Create Interaction"
      page.should have_content "Action successfully created."
    end

    it 'displays on index page' do 
      visit layer_path(@layer)
      page.should have_content "More Information"
    end

    it 'displays contentType png on index page'

    it 'displays on json' do
      visit layer_path(@layer)
      click_link '.json'
      #page.should have_content "actions"
    end

    it 'shows' do
      visit layer_path(@layer)
      find('#interaction_1').click_link "Show"
      page.current_path.should == layer_interaction_path(@layer, @interaction)
    end

    it 'edits' do
      visit layer_path(@layer)
      find('#interaction_1').click_link "Edit"
      fill_in "Label", :with => "More and More Info"
      click_button "Update Interaction"
      page.should have_content "Action successfully updated."
    end

    it 'deletes' do
      visit layer_path(@layer)
      find('#interaction_1').click_link 'Delete'
      page.should have_content "Action successfully deleted"
    end

    describe 'validates' do
      it 'that label and uri are required'
    end

  end

  describe 'belonging to Hotspot' do 
    
  end

end
