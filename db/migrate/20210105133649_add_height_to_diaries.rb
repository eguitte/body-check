class AddHeightToDiaries < ActiveRecord::Migration[5.2]
  def change
    add_column :diaries, :height, :integer
  end
end
