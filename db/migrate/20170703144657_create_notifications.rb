class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :owner_id
      t.integer :group_id
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
