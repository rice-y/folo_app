class Tag < ApplicationRecord
  has_many :project_tag_relations
  has_many :project, through: :project_tag_relations

  validates :name, uniqueness: true
end
