class ProjectsTag

  include ActiveModel::Model
  attr_accessor :name, :description, :title, :user_id

  with_options presence: true do
    validates :name
    validates :description
    validates :title
  end

  def save
    project = Project.create(name: name, description: description, user_id: user_id)
    tag = Tag.create(title: title)
    tag = Tag.where(title: title).first_or_initialize
    tag.save
    
    ProjectTagRelation.create(project_id: project.id, tag_id: tag.id)
  end

end