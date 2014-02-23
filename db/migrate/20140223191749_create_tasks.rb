class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.boolean :completed, null: false, default: false
      t.integer :user_id

      t.timestamps
    end
  end
end
