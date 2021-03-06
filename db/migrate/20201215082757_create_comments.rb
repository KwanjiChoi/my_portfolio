class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :comment, null: false
      t.references :commentable, polymorphic: true, index: true
      t.references :user, foreign_key: true, index: true
      t.timestamps
    end
  end
end
