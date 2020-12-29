class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.string :image
      t.integer :weight
      t.integer :fat
      t.integer :bmi
      t.integer :muscle
      t.integer :metabolism
      t.integer :organsfat
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
