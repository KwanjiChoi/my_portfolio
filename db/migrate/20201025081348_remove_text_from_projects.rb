class RemoveTextFromProjects < ActiveRecord::Migration[6.0]
  def up
    remove_column :projects, :text, :text
  end

  def down
    add_column :projects, :text, :text
  end
end
