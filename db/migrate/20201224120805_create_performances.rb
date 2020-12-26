class CreatePerformances < ActiveRecord::Migration[6.0]
  def change
    create_table :performances do |t|
      t.references :performancable, polymorphic: true, index: true
      t.integer :record
      t.float :average_score
      t.timestamps
    end
  end
end
