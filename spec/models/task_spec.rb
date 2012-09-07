require 'spec_helper'

TODAY = Date.current

describe Task do
	it "has a valid factory" do
    create(:task).should be_valid
	end

	it "is invalid without a title" do
	  build(:task, title: nil).should_not be_valid
	end

  it "returns only incomplete tasks when asked" do
    incomplete = create(:task, completed: false)
    complete = create(:task, completed: true)

    Task.incomplete.should == [incomplete]
  end

  context "splits tasks with newlines in the title" do
    before :each do
      @multiple_tasks = Task.build_one_or_more_tasks attributes_for(:task,
                                                                    title: "One\nTwo")
    end

   it { @multiple_tasks.should have(2).items }
   it { @multiple_tasks[0].title.should == "One" }
   it { @multiple_tasks[1].title.should == "Two" }
  end

	context "assigned dates" do
	  before :each do
	  	@yesterday = create(:task,
						  						title: "Yesterday's Task",
													assigned_date: (TODAY - 1))
	  	@today = create(:task,
											title: "Today's Task",
											assigned_date: TODAY)
	  	@tomorrow = create(:task,
												 title: "Tomorrow's Task",
												 assigned_date: (TODAY + 1))
	  	@past = create(:task,
	  	               title: "Past Task",
	  	               assigned_date: (TODAY - 2))
	  end

		it "is invalid with a dupilcate title on the same day" do
			build(:task,
			     	title: "Today's Task",
						assigned_date: TODAY).should_not be_valid
		end

		it "is valid with a duplicate title on different days" do
			build(:task,
						title: "Today's Task",
						assigned_date: TODAY + 1.day).should be_valid
		end

		it "returns only past tasks when asked" do
			Task.past.should == [@past]
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

    it "identfies today's tasks as being assigned to today" do
      @today.today?.should be_true
    end

    it "identfies yesteday's tasks as not being assigned to today" do
      @yesterday.today?.should be_false
    end

    context "reassigning" do
      it "moves very old tasks to today when reassigned" do
        @past.move_forward
         @past.assigned_date.should == TODAY
      end

      it "moves yesterday's tasks to today when reassigned" do
        @yesterday.move_forward
        @yesterday.assigned_date.should == TODAY
      end

      it "moves today's tasks to tomorrow when reassigned" do
        @today.move_forward
        @today.assigned_date.should == TODAY + 1
      end
    end

	end
end