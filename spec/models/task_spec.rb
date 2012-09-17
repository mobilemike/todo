require 'spec_helper'

TODAY = Date.current

describe Task do
  let(:completed_task) { create(:task, :completed) }
  let(:todays_task) { create(:task) }
  let(:past_task) { create(:task, :past) }
  let(:tomorrows_task) { create(:task, :tomorrow) }
  let(:yesterdays_task) { create(:task, :yesterday) }

  subject(:task) { todays_task }

  it "has a valid factory" do 
    should be_valid
  end

  context "by default" do
    it { should_not be_completed }
    its(:assigned_date) { should eq TODAY }
  end
  
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_uniqueness_of(:title).scoped_to(:assigned_date) }
  end

  describe "scopes" do
    describe ".incomplete" do
      let(:incomplete_tasks) { Task.incomplete }

      it "returns the incomplete tasks" do 
        incomplete_tasks.should == [task]
      end
    end

    describe ".past" do
      let(:past_tasks) { Task.past }

      it "finds the past tasks" do 
        past_tasks.should == [past_task]
      end
    end

    describe ".yesterday" do
      let(:yesterdays_tasks) { Task.yesterday }

      it "finds yesterday's tasks" do 
        yesterdays_tasks.should == [yesterdays_task]
      end
    end

    describe ".today" do
      let(:todays_tasks) { Task.today }

      it "finds today's tasks" do 
        todays_tasks.should == [todays_task]
      end
    end

    describe ".tomorrow" do
      let(:tomorrows_tasks) { Task.tomorrow }

      it "finds tomorrow's tasks" do 
        tomorrows_tasks.should == [tomorrows_task]
      end
    end

    describe "default scope" do
      let(:all_tasks) { Task.all }

      let!(:very_old_task) { create(:task, created_at: Time.now - 2.months) }
      let!(:ancient_task) { create(:task, created_at: Time.now - 3.months) }
      let!(:fresh_task) { create(:task) }
      let!(:old_task) { create(:task, created_at: Time.now - 1.month) }

      it "sorts tasks from oldest to newst by creation timestamp" do
        all_tasks.should eq [ancient_task, very_old_task, old_task, fresh_task]
      end
    end
  end

  describe ".find_by_scope" do
    context "valid scope name" do 
      it "calls the appropriate scope" do
        [:past, :yesterday, :today, :tomorrow].each do |scope|
          Task.should_receive scope

          Task.find_by_scope scope
        end
      end
    end

    context "invalid scope name" do
      it "raises a no record found error" do
        ->{ Task.find_by_scope(:invalid) }.
          should raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe ".build_one_or_more_tasks" do
    context "given a single line task title" do
      let(:task_attributes) { attributes_for(:task) }
      let(:tasks) { Task.build_one_or_more_tasks task_attributes }

      specify { tasks.should have(1).task }
      specify { tasks.first.title.should == task_attributes[:title] }
    end

    context "given a multiline task title" do
      task1_title = "Multiline Task 1"
      task2_title = "Multiline Task 2"
      title = task1_title + "\r\n" + task2_title + "\r\n"
      let(:task_attributes) { attributes_for(:task, title: title) }
      let(:tasks) { Task.build_one_or_more_tasks task_attributes }

      specify { tasks.should have(2).tasks }
      specify { tasks.first.title.should == task1_title }
      specify { tasks.second.title.should == task2_title }
    end
  end

  describe "#today?" do
    context "given a task assigned to today" do
      specify { todays_task.should be_today }
    end

    context "given a task assigned to yesterday" do
      specify { yesterdays_task.should_not be_today }
    end
  end

  describe "#move_forward" do
    context "given an incomplete task from the past" do
      it "moves the task forward to today" do
        expect{ past_task.move_forward }.
          to change{ past_task.assigned_date }.to(TODAY)
      end
    end

    context "given an incomplete task from yesteday" do
      it "moves the task forward to today" do
        expect { yesterdays_task.move_forward }.
          to change{ yesterdays_task.assigned_date }.to(TODAY)
      end
    end

    context "given an incomplete task from today" do
      it "moves the task forward to tomorrow" do
        expect { todays_task.move_forward }.
          to change { todays_task.assigned_date }.to(TODAY + 1)
      end
    end

    context "given an completed task" do
      it "does nothing" do
        expect { completed_task.move_forward }.
          to_not change { completed_task.assigned_date }
      end
    end
  end
end