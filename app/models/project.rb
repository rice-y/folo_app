class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  belongs_to :user

  def badge_color
    case status
      when 'undo'
        'danger'
      when 'doing'
        'warning'
      when 'done'
        'success'
    end
  end

  def status
    return 'undo' if tasks.none?

    if tasks.all? { |task| task.done? }
      'done'
    elsif tasks.any? { |task| task.doing? || task.done? }
      'doing'
    else
      'undo'
    end
  end

  def percent_complete
    return 0 if tasks.none?
    ((total_complete.to_f / total_tasks) * 100).round
  end

  def total_complete
    tasks.select { |task| task.done? }.count
  end

  def total_tasks
    tasks.count
  end
end


