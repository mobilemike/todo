require 'spec_helper'

describe List do
  
  describe "has a valid factory" do

    it "creates a valid object" do
      build(:list).class.should == List.new.class
    end

  end

  

end