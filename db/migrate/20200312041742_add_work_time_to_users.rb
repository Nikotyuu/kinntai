class AddWorkTimeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :started_time, :datetime, default: Time.current.change(hour: 7, min: 0, sec: 0)
    add_column :users, :finished_time, :datetime, default: Time.current.change(hour: 9, min: 0, sec: 0)
  end
end
