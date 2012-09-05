class Task < ActiveRecord::Base
  attr_accessible :title, :assigned_date, :completed
  
  validates :title, presence: true
  validates :title, uniqueness: {:scope => :assigned_date}

  default_scope order: 'created_at ASC'

  scope :past, ->{ where("assigned_date < ?", Date.yesterday) }
  scope :yesterday, ->{ where(:assigned_date => Date.yesterday) }
  scope :today, ->{ where(:assigned_date => Date.current) }
  scope :tomorrow, ->{ where(:assigned_date => Date.tomorrow) }
  scope :incomplete, where(completed: false)

  after_initialize :init

  def today?
    self.assigned_date == Date.current
  end

  def move_forward
    if self.assigned_date < Date.current
      self.update_attributes assigned_date: Date.current
    elsif self.assigned_date == Date.current
      self.update_attributes assigned_date: Date.current + 1
    end
  end

	private
  def init
    self.assigned_date ||= Date.current
  end

end