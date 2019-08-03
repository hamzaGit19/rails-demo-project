# frozen_string_literal: true

class AddProjectAssociationToTimeLogs < ActiveRecord::Migration[5.2]
  def change
    add_reference :time_logs, :project, foreign_key: true
  end
end
