# frozen_string_literal: true

class AddEmployeeToTimeLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :time_logs, :employee_id, :integer, null: false, default: -1
  end
end
