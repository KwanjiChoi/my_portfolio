class Locations < ActiveRecord::Migration[6.0]
  def change
    add_reference :project_locations, :project, foreign_key: true
  end
end
