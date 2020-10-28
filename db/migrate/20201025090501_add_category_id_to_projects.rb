class AddCategoryIdToProjects < ActiveRecord::Migration[6.0]
  def change
    add_reference :projects, :project_category, foreign_key: true
  end
end
