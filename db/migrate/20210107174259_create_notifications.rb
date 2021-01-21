class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :visited_id, null: false
      t.integer :visiter_id, null: false
      t.integer :notificatable_id, null: false
      t.string  :notificatable_type, null: false
      t.boolean :checked, default: false

      t.timestamps
    end

    add_index :notifications, [:notificatable_type, :notificatable_id]
  end
end
