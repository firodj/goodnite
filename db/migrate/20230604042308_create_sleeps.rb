class CreateSleeps < ActiveRecord::Migration[7.0]
  def change
    create_table :sleeps do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :sleep_at
      t.datetime :wakeup_at
      t.integer :duration

      t.timestamps
    end
  end
end
