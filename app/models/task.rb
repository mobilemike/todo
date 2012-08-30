class Task < ActiveRecord::Base
  attr_accessible :title, :assigned_date, :completed
  
  validates :title, presence: true
  validates :title, uniqueness: {:scope => :assigned_date}

  scope :past, ->{ where("assigned_date < ?", Date.yesterday) }
  scope :yesterday, ->{ where(:assigned_date => Date.yesterday) }
  scope :today, ->{ where(:assigned_date => Date.current) }
  scope :tomorrow, ->{ where(:assigned_date => Date.tomorrow) }
  scope :incomplete, where(completed: false)


  after_initialize :init

	private
  def init
    self.assigned_date ||= Date.current
  end

end