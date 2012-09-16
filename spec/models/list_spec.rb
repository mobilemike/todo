require 'spec_helper'

describe List do
  let(:example_tasks) { build_list(:task, 3) }
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
    context "with an example ID" do
      let(:id) { :past }

      it "sends the ID to a Task finder" do
        Task.should_receive(:find_by_scope).with(id)

        List.find id
      end

      it "initializes a new List with the Task finder's response and id" do
        List.should_receive(:new).with(example_tasks, id)
        Task.stub(:find_by_scope).and_return example_tasks

        List.find id
      end
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