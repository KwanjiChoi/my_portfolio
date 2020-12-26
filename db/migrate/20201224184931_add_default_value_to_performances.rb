class AddDefaultValueToPerformances < ActiveRecord::Migration[6.0]
  def up
    change_column :performances, :total_record, :integer, default: 0
  end

  def down
    change_column :performances, :total_record, :integer
  end
end
