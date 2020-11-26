class CreateProjectLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :project_locations do |t|
      t.string :prefecture_id

      t.timestamps
    end
  end
end
