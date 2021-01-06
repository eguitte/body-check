class ChangeDatatypeWeightOfDiaries < ActiveRecord::Migration[5.2]
  def change
    change_column :diaries, :weight, :float
  end
end
