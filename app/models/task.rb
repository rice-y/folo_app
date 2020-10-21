class Task < ApplicationRecord
  belongs_to :project

  validates :status, inclusion: { in:['undo', 'doing', 'done'] }

  STATUS_OPTIONS = [
    ['未実施(undo)', 'undo'],
    ['作業中(doing)', 'doing'],
    ['完了(done)', 'done']
  ]






  def badge_color
    case status
      when 'undo'
        'secondary'
      when'doing'
        'info'
      when 'done'
        'success'
    end
  end
end