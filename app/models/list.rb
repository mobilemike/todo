class List

  attr_accessor :tasks

  def initialize(tasks = [], id = nil)
    @tasks = tasks
    @id = id
  end

  def self.find id
    if [:past, :yesterday, :today, :tomorrow].include? id.to_sym
      send id
    else
      new
    end
  end

  def self.past
   new Task.where("assigned_date < ?", Date.yesterday), :past
  end

  def self.yesterday
    new Task.where(:assigned_date => Date.yesterday), :yesterday
  end

  def self.today
   new Task.where(:assigned_date => Date.current), :today
  end

  def self.tomorrow
    new Task.where(:assigned_date => Date.tomorrow), :tomorrow
  end

  def to_param
    @id
  end

  def move_forward
    ActiveRecord::Base.transaction do
      @tasks.each do |task|
        task.move_forward
      end
    end
  end

  def empty?
    @tasks.empty?
  end

  def has_incomplete_tasks?
    @tasks.any? { |task| !task.completed? }
  end

end