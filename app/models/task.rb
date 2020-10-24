class Task < ApplicationRecord
  belongs_to :project
  
  validates :name, :description, presence: true
  validates :status, inclusion: { in:['undo', 'doing', 'done'] }

  STATUS_OPTIONS = [
    ['未実施(undo)', 'undo'],
    ['作業中(doing)', 'doing'],
    ['完了(done)', 'done']
  ]

  def badge_color
    case status
      when 'undo'
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

  def undo?
    status == 'undo'
  end

end