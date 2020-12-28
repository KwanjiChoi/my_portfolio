class AddColumnToProjectLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :project_locations, :address, :string, null: false
    add_column :project_locations, :station, :string

    add_index :project_locations, :address
  end
end
