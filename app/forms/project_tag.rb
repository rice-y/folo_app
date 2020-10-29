class ProjectTag

  include ActiveModel::Model
  attr_accessor :description, :name, :name

  with_options presence: true do
    validates :description
    validates :name
  end

  def save
    project = Project.create(name: name, description: description)
    tag = Tag.create(name: name)
    tag = Tag.where(name: name).first_or_initialize
    tag.save
    
    ProjectTagRelation.create(project_id: Project.id, tag_id: tag.id)
  end

end