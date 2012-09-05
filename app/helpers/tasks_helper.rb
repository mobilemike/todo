module TasksHelper

  def task_edit_button task
    link_to '<i class="icon-pencil"></i>'.html_safe,
              edit_task_path(task), :class => 'btn btn-small' if task.assigned_date >= Date.current
  end

  def task_reassign_button task
    if !task.completed && (task.assigned_date <= Date.current)
      link_to('<i class="icon-arrow-right"></i>'.html_safe,
                task_reassignment_path(task), :method => :create,
                :class => 'btn btn-small')
    end
  end

end