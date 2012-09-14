require 'spec_helper'

describe List do
  let(:past_task) { create(:task, :past) }
  let(:todays_task) { create(:task) }
  let(:tomorrows_task) { create(:task, :tomorrow) }
  let(:yesterdays_task) { create(:task, :yesterday) }

  let(:example_tasks) { [past_task,
                         todays_task,
                         tomorrows_task,
                         yesterdays_task] }
  let(:example_list) { List.new(example_tasks) }

  describe ".initialize" do
    context "with no params" do
      it "defaults the tasks to empty array" do
        List.new.tasks.should == []
      end
    end

    context "with an array of tasks" do
      it "stores them for later retrieval" do
        example_list.tasks.should == example_tasks
      end
    end
  end

  describe ".find" do
    context "valid finders" do 
      it "calls the appropriate class method" do
        [:past, :yesterday, :today, :tomorrow].each do |finder|
          List.should_receive finder

          List.find finder
        end
      end
    end

    context "invalid finders" do
      it "calls the new class method" do
        List.should_receive :new

        List.find :invalid
      end
    end
  end

  describe ".past" do
    let(:past_list) { List.past }

    it "finds the past tasks" do 
      past_list.tasks.should == [past_task]
    end

    it "sets the ID to :past" do
      past_list.to_param.should == :past
    end
  end

  describe ".yesterday" do
    let(:yesterdays_list) { List.yesterday }

    it "finds yesterday's tasks" do 
      yesterdays_list.tasks.should == [yesterdays_task]
    end

    it "sets the ID to :yesterday" do
      yesterdays_list.to_param.should == :yesterday
    end
  end

  describe ".today" do
    let(:todays_list) { List.today }

    it "finds today's tasks" do 
      todays_list.tasks.should == [todays_task]
    end

    it "sets the ID to :today" do
      todays_list.to_param.should == :today
    end
  end

  describe ".tomorrow" do
    let(:tomorrows_list) { List.tomorrow }

    it "finds tomorrow's tasks" do 
      tomorrows_list.tasks.should == [tomorrows_task]
    end

    it "sets the ID to :tomorrow" do
      tomorrows_list.to_param.should == :tomorrow
    end
    end

  describe  "#to_param" do
    it "returns the list ID" do
      List.new(example_tasks, :test_id).to_param.should == :test_id
    end
  end

  describe "#move_forward" do
    let(:mock_task) { mock Task }

    it "tells each task to move forward" do
      mock_task.should_receive :move_forward

      List.new([mock_task]).move_forward
    end
  end

  describe "#empty?" do
    context "with no tasks" do
      it "is true" do
        List.new.should be_empty
      end
    end

    context "with tasks" do
      it "is false" do
        example_list.should_not be_empty
      end
    end
  end
  
  describe "#has_incomplete_tasks?" do
    context "with at least one incomplete task" do
      it "is true" do
        example_list.should have_incomplete_tasks
      end
    end

    context "with no incomplete tasks" do
      let(:complete_tasks) { create_list(:task, 3, :completed) }

      it "is false" do
      List.new(complete_tasks).should_not have_incomplete_tasks
      end 
    end

    context "with no tasks at all" do
      it "is false" do
        List.new.should_not have_incomplete_tasks
      end
    end
  end

end