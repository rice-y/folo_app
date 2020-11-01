class ProjectsTag

  include ActiveModel::Model
  attr_accessor :name, :description, :title, :user_id

  with_options presence: true do
    validates :name
    validates :description
    validates :title
  end


  def initialize(attributes = nil, project: Project.new)  
    @project = project
    attributes ||= default_attributes
    super(attributes)
  end

  def update
    return if invalid?

    ActiveRecord::Base.transaction do
      tag = split_tag_titles.map { |title| Tag.find_or_create_by!(title: title) }
      project.update!(name: name, description: description)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end
  
  def save
    project = Project.create(name: name, description: description, user_id: user_id)
    tag = Tag.create(title: title)
    tag = Tag.where(title: title).first_or_initialize
    tag.save
    
    ProjectTagRelation.create(project_id: project.id, tag_id: tag.id)
  end

  private

  attr_reader :project

  def default_attributes
    {
      name: project.name,
      description: project.description,
      title: project.tags.pluck(:title).join(',')
    }
  end

  def split_tag_titles
    title.split(',')
  end


end