class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :project_tag_relations, dependent: :destroy
  has_many :tags, through: :project_tag_relations
  belongs_to :user
  after_create :create_task

  validates :name, :description, presence: true

  def badge_color
    case status
      when 'not-started'
        'danger'
      when 'doing'
        'warning'
      when 'done'
        'success'
    end
  end

  def status
    return 'not-started' if tasks.none?

    if tasks.all? { |task| task.done? }
      'done'
    elsif tasks.any? { |task| task.doing? || task.done? }
      'doing'
    else
      'not-started'
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

  private
  
    def create_task
        Task.create(:name => "タスク名を入力", :description => "本文を入力", :status => "not-started", project_id: @project)
    
    end
end


