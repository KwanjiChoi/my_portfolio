class AddColumnsToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :main_image, :string, null: false
  end
end
