class ChangeDataTypeForAdminFromUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :admin, :integer, default: 0
  end
end
