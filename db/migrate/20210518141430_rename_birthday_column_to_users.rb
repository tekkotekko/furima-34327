class RenameBirthdayColumnToUsers < ActiveRecord::Migration[6.0]
  def change
  rename_column :users, :birthday, :birth_date
  end
end
