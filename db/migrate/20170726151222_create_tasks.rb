class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :description
      t.string :state, default: 'new'
      t.date :due

      t.timestamps
    end
  end
end
