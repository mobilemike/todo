require 'spec_helper'

TODAY = Date.today

describe Task do
	it "has a valid factory" do
    FactoryGirl.create(:task).should be_valid
	end

	it "is invalid without a title" do
	  FactoryGirl.build(:task, title: nil).should_not be_valid
	end

	context "using scopes" do
	  before :each do
	  	@yesterday = FactoryGirl.create(:task,
						  												title: "Yesterday's Task",
																			assigned_date: (TODAY - 1))
	  	@today = FactoryGirl.create(:task,
																	title: "Today's Task",
																	assigned_date: TODAY)
	  	@tomorrow = FactoryGirl.create(:task,
																		 title: "Tomorrow's Task",
																		 assigned_date: (TODAY + 1))
	  end

		it "is invalid with a dupilcate title on the same day" do
			FactoryGirl.build(:task,
												 title: "Today's Task",
												 assigned_date: TODAY).should_not be_valid
		end

		it "is valid with a duplicate title on different days" do
			FactoryGirl.build(:task,
												 title: "Today's Task",
												 assigned_date: TODAY + 1.day).should be_valid
		end
      
		it "returns only yesterdays tasks when asked" do
			Task.yesterday.should == [@yesterday]
		end

		it "returns only todays tasks when asked" do
			Task.today.should == [@today]
		end

		it "returns only tomorrows tasks when asked" do
			Task.tomorrow.should == [@tomorrow]
		end

	end
end