require 'spec_helper'

describe Task do
	it "has a valid factory" do
    FactoryGirl.create(:task).should be_valid
	end

	it "is invalid without a title" do
	  FactoryGirl.build(:task, title: nil).should_not be_valid
	end

	it "is invalid with a dupilcate title" do
		FactoryGirl.create(:task, title: "duplicated title")
		FactoryGirl.build(:task, title: "duplicated title").should_not be_valid
	end
end