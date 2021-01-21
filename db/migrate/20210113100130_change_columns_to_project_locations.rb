class ChangeColumnsToProjectLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :project_locations, :city_id, :integer, null: false
    remove_column :project_locations, :address, :string
    change_column_null :project_locations, :prefecture_id, false
  end
end
