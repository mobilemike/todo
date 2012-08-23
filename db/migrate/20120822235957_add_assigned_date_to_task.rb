class AddAssignedDateToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :assigned_date, :date
  end
end
