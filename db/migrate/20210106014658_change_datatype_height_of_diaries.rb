class ChangeDatatypeHeightOfDiaries < ActiveRecord::Migration[5.2]
  def change
    change_column :diaries, :height, :float
  end
end
