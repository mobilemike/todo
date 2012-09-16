class List

  attr_accessor :tasks

  def initialize(tasks = [], id = nil)
    @tasks = tasks
    @id = id
  end

  def self.find id
    new Task.find_by_scope(id), id
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