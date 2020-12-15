class AddPrefectureIdToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :prefecture_id, :string
  end
end
