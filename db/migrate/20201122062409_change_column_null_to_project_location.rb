class ChangeColumnNullToProjectLocation < ActiveRecord::Migration[6.0]
  def change
    change_column_null :project_locations, :project_id, false
  end
end
