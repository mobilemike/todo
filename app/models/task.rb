class Task < ActiveRecord::Base
  attr_accessible :title, :assigned_date
  
  validates :title, presence: true
  validates :title, uniqueness: {:scope => :assigned_date}

  scope :yesterday, ->{ where(:assigned_date => Date.yesterday)}
  scope :today, ->{ where(:assigned_date => Date.today)}
  scope :tomorrow, ->{ where(:assigned_date => Date.tomorrow)}


  after_initialize :init

	private
  def init
    self.assigned_date ||= Date.today
  end

end