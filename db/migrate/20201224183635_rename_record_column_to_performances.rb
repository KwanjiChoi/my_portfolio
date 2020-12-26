class RenameRecordColumnToPerformances < ActiveRecord::Migration[6.0]
  def change
    rename_column :performances, :record, :total_record
  end
end
