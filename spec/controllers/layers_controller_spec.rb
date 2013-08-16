require 'spec_helper'

describe LayersController do

  before do
		@user = User.create! :username => 'driscocp'
		CASClient::Frameworks::Rails::Filter.fake(@user)
    @layer = Layer.create :name => 'Test Layer'
    @layer.hotspots.create :title => "Hotspot 1", :latitude => 100, :longitude => 100
  end

  describe "GET /layers" do
    it "should display layers page" do
      visit layers_path
      page.current_path.should == layers_path
    end
  end

end
