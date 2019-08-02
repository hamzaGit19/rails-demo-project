# frozen_string_literal: true

class AddCostToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :cost, :float
  end
end
