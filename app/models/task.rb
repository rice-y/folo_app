class Task < ApplicationRecord
  belongs_to :project

  validates :status, inclusion: { in:['undo', 'doing', 'done'] }

  STATUS_OPTIONS = [
    ['未実施', 'undo'],
    ['作業中', 'doing'],
    ['完了', 'done']
  ]

end