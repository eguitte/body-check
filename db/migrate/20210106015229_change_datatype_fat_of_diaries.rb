class ChangeDatatypeFatOfDiaries < ActiveRecord::Migration[5.2]
  def change
    change_column :diaries, :fat, :float
  end
end
