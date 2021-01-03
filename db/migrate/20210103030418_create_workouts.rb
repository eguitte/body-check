class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.string :title
      t.text :content
      t.datetime :start_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
