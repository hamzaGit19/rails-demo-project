class AddStatusToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :status, :string
    add_column :projects, :type, :string
  end
end