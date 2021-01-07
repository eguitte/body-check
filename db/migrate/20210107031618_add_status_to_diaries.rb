class AddStatusToDiaries < ActiveRecord::Migration[5.2]
  def change
    add_column :diaries, :status, :integer, default: 1, null: false, limit: 1
  end
end
