class Task < ActiveRecord::Base
  attr_accessible :title, :assigned_date, :completed
  
  validates :title, presence: true
  validates :title, uniqueness: {:scope => :assigned_date}

  default_scope order: 'created_at ASC'

  scope :incomplete, where(completed: false)

  after_initialize :init

  def self.build_one_or_more_tasks attributes={}
    attributes[:title].split("\n").map do |title|
      attributes[:title] = title.strip
      self.new attributes
    end
  end

  def today?
    self.assigned_date == Date.current
  end

  def move_forward
    unless self.completed?
      if self.assigned_date < Date.current
        self.update_attributes assigned_date: Date.current
      elsif self.assigned_date == Date.current
        self.update_attributes assigned_date: Date.current + 1
      end
    end
  end

	private
  def init
    self.assigned_date ||= Date.current
  end

end