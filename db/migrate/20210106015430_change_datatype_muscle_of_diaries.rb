class ChangeDatatypeMuscleOfDiaries < ActiveRecord::Migration[5.2]
  def change
    change_column :diaries, :muscle, :float
  end
end
