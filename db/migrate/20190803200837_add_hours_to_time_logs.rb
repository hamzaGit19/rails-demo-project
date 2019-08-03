# frozen_string_literal: true

class AddHoursToTimeLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :time_logs, :hours, :integer, null: false, default: 1
    add_column :time_logs, :creator_id, :integer, null: false, default: -1
  end
end
