class CreateProjectTagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :project_tag_relations do |t|
      t.references :project, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
