class RemovePrefectureIdFromProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :prefecture_id, :string
  end
end
