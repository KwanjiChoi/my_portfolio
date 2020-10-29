class AddColumnToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :phone_reservation, :boolean, default: false
  end
end
