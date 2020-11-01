class Task < ApplicationRecord
  belongs_to :project
  
  validates :name, :description, presence: true
  validates :status, inclusion: { in:['not-started', 'doing', 'done'] }

  STATUS_OPTIONS = [
    ['未実施(not-started)', 'not-started'],
    ['作業中(doing)', 'doing'],
    ['完了(done)', 'done']
  ]

  def badge_color
    case status
      when 'not-started'
        'danger'
      when'doing'
        'warning'
      when 'done'
        'success'
    end
  end

  def done?
    status == 'done'
  end

  def doing?
    status == 'doing'
  end

  def started?
    status == 'not-started'
  end

end